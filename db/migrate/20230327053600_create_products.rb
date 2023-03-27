class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :Name
      t.string :Perropoints
      t.string :Description , limit: 1000
      t.string :NutritionalInfo , limit: 1000
      t.string :FeedingInstructions , limit: 1000
      t.string :Highlight , limit: 1000
      t.references :product_sub_category, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
