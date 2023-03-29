class CreateDealImages < ActiveRecord::Migration[7.0]
  def change
    create_table :deal_images do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
