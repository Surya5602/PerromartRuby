class AddPetTypeToPopularCategory < ActiveRecord::Migration[7.0]
  def change
    add_reference :popular_categories, :pet_type, null: false, foreign_key: true
  end
end
