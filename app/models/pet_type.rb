class PetType < ApplicationRecord
    has_many :deals
    has_one :pet_image
    has_many :popular_categories
end
