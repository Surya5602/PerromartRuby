class ReviewController < ApplicationController
  include UserDetails

  def add_review
    value = request.body.string
    value = JSON.parse(value)
    token = request.headers["Authorization"]
    user = decode_token(token)
    rating = value["ProductRating"]
    title = value["Review Title"]
    review = value["Review"]
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    if value != nil
      if user != nil
        product = Product.find_by(UUID: uuid)
        if product != nil
        review = product.reviews.new(Rating: rating, ReviewTitle: title, Review: review ,user_id: user.id)
        review.save
        render json: { status: true, message: "Review added successfully" }
        else
          render json: { status: false, message: "product is not found" }
        end
      else
        render json: { status: false, message: "User is not present" }
      end
    else
      render json: { status: false, message: "values should be not null" }
    end
  end
end
