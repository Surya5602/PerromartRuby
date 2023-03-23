class CreateOtpVerifications < ActiveRecord::Migration[7.0]
  def change
    create_table :otp_verifications do |t|
      t.string :MobileNumber
      t.integer :otp

      t.timestamps
    end
  end
end
