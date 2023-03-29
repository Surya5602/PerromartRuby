class CreatePopularCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_categories,if_not_exists: true do |t|
      t.string :category
      t.string :image_url

      t.timestamps
    end
  end
end
