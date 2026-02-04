class AddOtpToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :otp_digest, :string
    add_column :users, :otp_sent_at, :datetime
    add_column :users, :phone_verified, :boolean
  end
end
