class CreatePets < ActiveRecord::Migration[7.0]
  def change
    create_table :pets do |t|
      t.string :image_url
      t.string :Name
      t.string :PetType
      t.string :Gender
      t.string :Breed
      t.date :Birthday
      t.integer :Weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
