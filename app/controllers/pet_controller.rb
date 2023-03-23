class PetController < ApplicationController
  include UserDetails

  def add_pet
    values = request.body.string
    values = JSON.parse(values)
    token = request.headers["Authorization"]
    user = decode_token(token)
    birthday = Date.parse(values["Birthday"])
    if !values.empty?
      @pet = Pet.new(Name: values["Name"], PetType: values["PetType"], Gender: values["Gender"], Breed: values["Breed"], Birthday: birthday, Weight: values["Weigth"], user_id: user.id)
      @pet.save
      values["PreExistingConditions"].each do |i|
        condition = @pet.pre_existing_condition.create(value: i)
      end
      values["ToyPreference"].each do |i|
        toy = @pet.toy_preference.create(value: i)
      end
      values["FoodAllergies"].each do |i|
        allergy = @pet.food_allergy.create(value: i)
      end
      render json: { status: true, message: "pet added successfully" }
    end
  end

  def pets_details
    token = request.headers["Authorization"]
    user = decode_token(token)
    pets_arr = []
    pets = user.pets
    pets.each do |i|  
      data = {petsDetails: {petData: i , PreExistingConditions: i.pre_existing_condition , ToyPreference: i.toy_preference, FoodAllergy: i.food_allergy}}
      pets_arr << data
    end
      if user.present?
        render json: { status: true, message: "Data of user", petDetails: pets_arr }
      else
        render json: { status: false, message: "User is not present" }
      end
   
  end
end
