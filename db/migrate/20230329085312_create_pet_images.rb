class CreatePetImages < ActiveRecord::Migration[7.0]
  def change
    create_table :pet_images do |t|
      t.string :image_url
      t.references :pet_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
