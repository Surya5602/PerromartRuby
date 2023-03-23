class CreatePreExistingConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :pre_existing_conditions do |t|
      t.string :value
      t.references :pet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
