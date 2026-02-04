class TwilioOtpService
  def initialize
    @client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
  end

  def send_otp(phone_number, otp)
    @client.messages.create(
      from: "whatsapp:+14155238886", # Twilio WhatsApp Sandbox
      to: "whatsapp:#{phone_number}",
      body: "🔐 Your OTP is *#{otp}*\n\nValid for 5 minutes."
    )
  end
end
