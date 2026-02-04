class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room

  has_one_attached :file

  validates :content, presence: true

  after_create_commit :handle_after_create

  private

  # 🔔 Single entry point after message is created
  def handle_after_create
    broadcast_message
    send_email_notification
    notify_via_whatsapp
  end

  # 📡 Realtime message broadcast
  def broadcast_message
    ChatRoomChannel.broadcast_to(chat_room, self)
  end

  # 📧 Email notification
  def send_email_notification
    MessageMailer.new_message_email(self).deliver_later
  end

  # 💬 WhatsApp notification via Twilio (only for offline users)
  def notify_via_whatsapp
    recipients = User
      .where.not(id: user_id)
      .where.not(phone_number: nil)
      .select { |u| !u.online? }

    return if recipients.empty?

    service = TwilioWhatsappService.new

    recipients.each do |recipient|
      begin
        WhatsappNotificationJob.perform_later(
          to: recipient.phone_number,
          body: "💬 New message from #{user.email}:\n#{content}"
        )
      rescue Twilio::REST::RestError => e
        Rails.logger.error "WhatsApp notification failed: #{e.message}"
      end
    end
  end
end




