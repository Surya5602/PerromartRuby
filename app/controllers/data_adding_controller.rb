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
          category.product_sub_categories.create(SubCategory: j, PetType: pet)
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

  def add_product
    values = request.body.string
    values = JSON.parse(values)
    if values != nil
      brand = Brand.new(Name: values["BrandName"])
      brand.save
      product_sub_category = ProductSubCategory.find_by(SubCategory: values["subCategory"])
      if product_sub_category.present?
        product = brand.products.create(Name: values["Name"], Perropoints: values["perropoints"], Description: values["Description"], NutritionalInfo: values["Nutritional info"], FeedingInstructions: values["Feeding instructions"], Highlight: values["Highlight"], product_sub_category_id: product_sub_category.id)
        values["size"].each do |i|
          size = product.size_of_products.create(size: i, price: values["price"][i])
        end
        values["image_url"].each do |i|
          image = product.product_images.create(image_url: i)
        end
        render json: { status: true, message: "Product added" }
      else
        render json: { status: false, message: "sub Category not found" }
      end
    else
      render json: { status: false, message: "Can't be null" }
    end
  end
end
