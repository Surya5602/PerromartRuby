class ProductController < ApplicationController
  def fetch_brand
    brand = Brand.find_by(Name: params[:brand])
    product = brand.products
    result_array = []
    product.each do |i|
      value = { Product: i, ProductSubCategory: i.product_sub_category.SubCategory, PetType: i.product_sub_category.PetType, ProductImages: i.product_images.pluck(:image_url) }
      result_array << [value]
    end
    render json: { status: true, data: result_array }
  end

  def fetch_product
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    product = Product.find_by(UUID: uuid)
    if product.present?
      result = { Product: product, ProductImages: product.product_images.pluck(:image_url), ProductSubCategory: product.product_sub_category.SubCategory, PetType: product.product_sub_category.PetType }
      render json: { status: true, data: result }
    else
      render json: { status: false, message: "No product found in provided UUID" }
    end
  end

  def fetch_category
    value = params[:category]
    value = value.split("-")
    category = ProductSubCategory.find_by(PetType: value[0], SubCategory: value[1])
    if category.present?
      product = category.products.select(:Name, :Perropoints, :Description, :NutritionalInfo, :FeedingInstructions, :Highlight, :UUID)
      if product.present?
        render json: { status: true, data: product }
      else
        render json: { status: false, message: "No products found" }
      end
    else
      render json: { status: false, message: "No category found" }
    end
  end
end
