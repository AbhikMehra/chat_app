class OtpsController < ApplicationController
  before_action :authenticate_user!

  # 📩 Send OTP
  def create
    # Ensure user has phone number
    if current_user.phone_number.blank?
      redirect_to root_path, alert: "Please add your phone number first"
      return
    end

    otp = current_user.generate_otp!

    # ✅ Async (Sidekiq-ready)
    TwilioOtpJob.perform_later(current_user.id)

    redirect_to verify_otp_path, notice: "OTP sent to your phone"
  end

  # 🧾 OTP input page
  def verify
    # just renders the form
  end

  # ✅ Confirm OTP
  def confirm
    if current_user.verify_otp?(params[:otp])
      current_user.update!(phone_verified: true)

      redirect_to root_path, notice: "✅ Phone number verified"
    else
      flash.now[:alert] = "❌ Invalid or expired OTP"
      render :verify, status: :unprocessable_entity
    end
  end
end
