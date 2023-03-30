class RemoveColumnsFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :product_references, :string
    remove_column :reviews, :user_references, :string
  end
end
