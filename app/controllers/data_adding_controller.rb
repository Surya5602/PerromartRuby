class DataAddingController < ApplicationController
  def category
    values = request.body.string
    values = JSON.parse(values)
    values["Categories"].each do |i|
      product = ProductCategory.new(Category: i)
      product.save
    end
    render json: { status: true, message: "Data added successfully" }
  end

  def sub_category
    type = ["Dog", "Cat"]
    array = ["Food", "Healthcare", "Treats", "Clean", "Accessories", "Toys"]
    values = request.body.string
    values = JSON.parse(values)
    type.each do |pet|
      array.each do |category_value|
        values[pet][category_value].each do |j|
          category = ProductCategory.find_by(Category: category_value)
          category.product_sub_categories.create(SubCategory: j , PetType: pet )
        end
      end
    end
    render json: { status: true, message: "Data added successfully" }
  end

  def carousel
    values = request.body.string
    values = JSON.parse(values)
    values["image_url"].each do |i|
        carousel = Carousel.new(image_url: i)
        carousel.save        
    end
    render json: { status: true, message: "Data added successfully" }
  end

  
  
end
