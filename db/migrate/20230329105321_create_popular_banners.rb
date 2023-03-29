class CreatePopularBanners < ActiveRecord::Migration[7.0]
  def change
    create_table :popular_banners do |t|
      t.string :image_url

      t.timestamps
    end
  end
end
