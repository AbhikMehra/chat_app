class MessageMailer < ApplicationMailer
  default from: "no-reply@chatapp.com"

  def new_message_email(message)
    @message   = message
    @chat_room = message.chat_room
    @user      = message.user

    recipients = User.where.not(id: @user.id).pluck(:email)

    return if recipients.empty?   # ✅ IMPORTANT FIX

    mail(
      to: recipients,
      subject: "New message in #{@chat_room.name}"
    )
  end
end

