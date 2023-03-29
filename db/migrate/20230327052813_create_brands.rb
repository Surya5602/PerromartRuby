class CreateBrands < ActiveRecord::Migration[7.0]
  def change
    create_table :brands do |t|
      t.string :Name
      t.string :image_url

      t.timestamps
    end
  end
end
