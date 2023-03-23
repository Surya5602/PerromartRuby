class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Email
      t.string :Password
      t.date :DateOfBirth
      t.string :Gender
      t.string :MobileNumber

      t.timestamps
    end
  end
end
