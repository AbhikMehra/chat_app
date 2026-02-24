require "bcrypt"

class User < ApplicationRecord
  include BCrypt
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
 
  has_many :messages
  validates :phone_number, presence: true

  has_many :payments

  def online?
    last_seen_at.present? && last_seen_at > 2.minutes.ago
  end

  def generate_otp!
    otp = rand(100000..999999).to_s
    self.otp_digest = Password.create(otp)
    self.otp_sent_at = Time.current
    save!(validate: false)
    otp
  end

  def verify_otp?(otp)
    return false if otp_sent_at < 5.minutes.ago
    Password.new(otp_digest) == otp
  end

end





