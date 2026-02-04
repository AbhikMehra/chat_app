class TwilioOtpJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)
    TwilioOtpService.new(user).call
  end
end
