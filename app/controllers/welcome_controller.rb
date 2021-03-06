class WelcomeController < ApplicationController

  def result
    RakutenWebService.configuration do |c|
      c.application_id = ENV["APPID"]
      c.affiliate_id = ENV["AFID"]
  end

  @author = params[:author]
  @books = RakutenWebService::Books::Book.search(:author => params[:author],)

  end
end
