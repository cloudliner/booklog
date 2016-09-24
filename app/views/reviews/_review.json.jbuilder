json.extract! review, :id, :isbn, :title, :auther, :review, :created_at, :updated_at
json.url review_url(review, format: :json)