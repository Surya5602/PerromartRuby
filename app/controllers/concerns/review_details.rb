module ReviewDetails
  def rating(uuid)
    product = Product.find_by(UUID: uuid)
    hash = {}
    if product.present?
      review = product.reviews.pluck(:Rating)
      review = review.sum
      count = product.reviews.pluck(:Rating).count
      average_rating = review.to_f / count.to_f 
    end
    hash["total_count"] = count
    hash["average_rating"] = average_rating
    return hash
  end
end
