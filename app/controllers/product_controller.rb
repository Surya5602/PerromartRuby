class ProductController < ApplicationController
  include UserDetails
  include ReviewDetails
  def fetch_brand
    brand = Brand.find_by(Name: params[:brand])
    product = brand.products
    result_array = []
    product.each do |i|
      review = rating(i.UUID)
      value = { Product: i, ProductSubCategory: i.product_sub_category.SubCategory, PetType: i.product_sub_category.PetType, ProductImages: i.product_images.pluck(:image_url), rating: review}
      result_array << [value]
    end
    render json: { status: true, data: result_array }
  end

  def fetch_product
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    product = Product.find_by(UUID: uuid)
    review = rating(uuid)
    if product.present?
      result = { Product: product, ProductImages: product.product_images.pluck(:image_url), ProductSubCategory: product.product_sub_category.SubCategory, PetType: product.product_sub_category.PetType , rating: review}
      render json: { status: true, data: result }
    else
      render json: { status: false, message: "No product found in provided UUID" }
    end
  end

  def fetch_category
    value = params[:category]
    value = value.split("-")
    category = ProductSubCategory.find_by(PetType: value[0], SubCategory: value[1])
    hash = {}
    result_array = []
    if category.present?
      product = category.products.select(:id ,:Name, :Perropoints, :Description, :NutritionalInfo, :FeedingInstructions, :Highlight, :UUID)
      product.each do |i|
      hash["product_details"] = i
      hash["product_rating"] = rating(i.UUID)
      result_array << hash
      end
      if product.present?
        render json: { status: true, data: result_array }
      else
        render json: { status: false, message: "No products found" }
      end
    else
      render json: { status: false, message: "No category found" }
    end
  end

  #liking products maintaining
  def add_like
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    token = request.headers["Authorization"]
    user = decode_token(token)
    product = Product.find_by(UUID: uuid)
    if user.present?
      if product.present?
        like = Like.find_by(user_id: user.id, product_id: product.id)
        if like.present?
          like.destroy
          render json: { status: true, message: "Product is unliked" }
        else
          like = Like.new(user_id: user.id, product_id: product.id)
          like.save
          render json: { status: true, message: "Product is liked" }
        end
      else
        render json: { status: false, message: "Product is not found" }
      end
    else
      render json: { status: false, message: "User is not present" }
    end
  end

  def liked_products
    token = request.headers["Authorization"]
    user = decode_token(token)
    product_array = []
    if user.present?
      likes = user.likes.pluck(:product_id)
      likes.each do |i|
        product = Product.select(:id, :Name, :Perropoints, :Description, :NutritionalInfo, :FeedingInstructions, :Highlight, :UUID).find(i)
        product_image = product.product_images.pluck(:image_url)
        product_array << [product, product_image]
      end
      render json: { status: true, liked_products: product_array }
    else
      render json: { status: false, message: "User is not present" }
    end
  end

  #Cart data maintaining
  def add_cart
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    token = request.headers["Authorization"]
    user = decode_token(token)
    product = Product.find_by(UUID: uuid)
    if user.present?
      if product.present?
        cart = Cart.new(user_id: user.id, product_id: product.id)
        cart.save
        render json: { status: true, message: "Product is added to cart" }
      else
        render json: { status: false, message: "Product is not found" }
      end
    else
      render json: { status: false, message: "User is not present" }
    end
  end

  def remove_cart
    uuid = request.query_parameters
    uuid = uuid["UUID"]
    token = request.headers["Authorization"]
    user = decode_token(token)
    product = Product.find_by(UUID: uuid)
    cart = Cart.find_by(user_id: user.id, product_id: product.id)
    if cart.present?
      cart.destroy
      render json: { status: true, message: "Product removed from cart" }
    else
      render json: { status: false, message: "user does not added this product to cart" }
    end
  end

  def cart_products
    token = request.headers["Authorization"]
    user = decode_token(token)
    product_array = []
    if user.present?
      carts = user.carts.pluck(:product_id)
      carts.each do |i|
        product = Product.select(:id, :Name, :Perropoints, :Description, :NutritionalInfo, :FeedingInstructions, :Highlight, :UUID).find(i)
        product_image = product.product_images.pluck(:image_url)
        product_array << [product, product_image]
      end
      render json: { status: true, product_ids_in_cart: product_array }
    else
      render json: { status: false, message: "User is not present" }
    end
  end
end
