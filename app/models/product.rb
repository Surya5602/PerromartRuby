class Product < ApplicationRecord
  has_many :product_images
  has_many :size_of_products
  belongs_to :product_sub_category
  belongs_to :brand
  has_many :likes
  has_many :carts
  has_many :reviews
end
