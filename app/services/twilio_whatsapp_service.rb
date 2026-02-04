class TwilioWhatsappService
  def initialize
    @client = Twilio::REST::Client.new(
      ENV["TWILIO_ACCOUNT_SID"],
      ENV["TWILIO_AUTH_TOKEN"]
    )
  end

  def send_whatsapp(to:, body:)
    @client.messages.create(
      from: "whatsapp:+14155238886",
      to: "whatsapp:#{to}",
      body: body
    )
  end
end
