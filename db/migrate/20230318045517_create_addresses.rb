class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.integer :UnitNo
      t.string :address
      t.string :Country
      t.integer :PostalCode     
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
