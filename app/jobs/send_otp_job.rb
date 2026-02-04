class SendOtpJob < ApplicationJob
  queue_as :default

  def perform(phone_number, otp)
    TwilioOtpService.new.send_otp(phone_number, otp)
  end
end

