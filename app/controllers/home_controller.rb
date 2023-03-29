class HomeController < ApplicationController
  include UserDetails

  def home_page
    token = request.headers["Authorization"]
    user = decode_token(token)

    #navbar 1 data fetching

    brand = Brand.all.pluck(:Name, :image_url)
    petType = PetType.all.pluck(:name)
    result = Hash.new
    navbar1 = Hash.new
    petType.each do |petName|
      pet = PetType.select(:name, :id).find_by(Name: petName)
      deals = pet.deals.pluck(:deal_name)
      result[pet.name] = deals
    end
    images = DealImage.all.pluck(:image_url)
    navbar1["brand"] = brand
    navbar1["deals"] = [result, images]
    navbar1["user"] = user.Name
    navbar1["likesCount"] = user.likes.count
    navbar1["cartCount"] = user.carts.count

    #navbar 2 data fetching
    product = ProductCategory.all.pluck(:Category)
    category_hash = Hash.new
    pet_hash = Hash.new
    petType.each do |pet|
      product.each do |i|
        category = ProductCategory.find_by(Category: i )
        sub_category = category.product_sub_categories.pluck(:SubCategory)
        
        category_hash[category.Category] = sub_category
        
      end
      pet_hash[pet] = category_hash
    end

    #carousel values
    carousel = Carousel.all.pluck(:image_url)

    #product values
    product = product_details()
        
    #result_array
    result_array = []
    result_array << navbar1
    result_array << pet_hash
    result_array << carousel
    result_array << product    
    render json: {status: true , data: result_array}
  end

  def product_details
    product_price = Hash.new
    product = Product.all.select(:Name, :Perropoints, :Description, :NutritionalInfo, :FeedingInstructions, :Highlight, :UUID ,:id).limit(5)
    hash = Hash.new
    product.each do |i|
    price = i.size_of_products.limit(1).pluck(:price)  
    images = i.product_images.pluck(:image_url)  
    product_details = {Name: i.Name ,Perropoints: i.Perropoints,Description: i.Description ,NutritionalInfo: i.NutritionalInfo , FeedingInstructions: i.FeedingInstructions , Highlight: i.Highlight , UUID: i.UUID   }
    hash[i.id] = {product_details: product_details, product_images: images , product_price: price[0]}
    end
    return hash
  end

  def scroll_1
    product = product_details()
    petType = PetType.all.pluck(:name)
    pet_hash = {}
    petType.each do |pet|
        animal = PetType.find_by(name: pet)
        popular_category = animal.popular_categories.limit(5).pluck(:category , :image_url)
        pet_hash[animal.name] = popular_category
    end
    brand = Brand.all.pluck(:Name , :image_url)
    banner = PopularBanner.all.pluck(:image_url)
    render json: {status: true , data: {product: product , popular_categories: pet_hash , Banner: banner ,featured_brands: brand}}       
  end

end
