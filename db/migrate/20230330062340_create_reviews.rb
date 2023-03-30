class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews , if_not_exists: true  do |t|
      t.integer :Rating
      t.string :ReviewTitle
      t.string :Review
      t.string :product_references
      t.string :user_references

      t.timestamps
    end
  end
end
