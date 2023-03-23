class Pet < ApplicationRecord
    belongs_to :user 
    has_many :toy_preference
    has_many :pre_existing_condition
    has_many :food_allergy
end
