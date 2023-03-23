class CreateProductSubCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :product_sub_categories do |t|
      t.string :SubCategory
      t.references :product_category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
