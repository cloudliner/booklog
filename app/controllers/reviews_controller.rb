class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :rakuten_api

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = Review.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    book = find(@review.isbn)
    unless book.nil? then
      @review.image_url = book.large_image_url
    end
  end

  # GET /reviews/new
  def new
    @review = Review.new
    if params[:isbn] then
      book = find(params[:isbn])
      unless book.nil? then
        @review.isbn = book.isbn
        @review.title = book.title
        @review.auther = book.author
      end
    end
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:isbn, :title, :auther, :review)
    end

    # For Rakuten API Setting
    def rakuten_api
      RakutenWebService.configuration do |c|
        c.application_id = ENV["APPID"]
        c.affiliate_id = ENV["AFID"]
      end
    end

    # Find by isbn
    def find(isbn)
      books = RakutenWebService::Books::Book.search(:isbn => isbn)
      unless books.nil? && books.empty? then
        book = books.first
        return book;
      end
    end  
end
