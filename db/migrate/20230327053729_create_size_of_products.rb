class CreateSizeOfProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :size_of_products do |t|
      t.string :size
      t.string :price
      t.references :product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
