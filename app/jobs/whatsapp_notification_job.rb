class WhatsappNotificationJob < ApplicationJob
  queue_as :default

  def perform(recipient_phone, message_body)
    TwilioWhatsappService.new.send_whatsapp(
      to: recipient_phone,
      body: message_body
    )
  end
end

