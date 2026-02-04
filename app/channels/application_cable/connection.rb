module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      puts "🔥 ACTION CABLE CONNECTED"
      self.current_user = find_verified_user
      puts "👤 USER: #{current_user.email}"
      current_user.update!(online: true)
    end

    def disconnect
      puts "❌ ACTION CABLE DISCONNECTED"
      current_user.update!(online: false) if current_user
    end

    protected

    def find_verified_user
      env["warden"].user || reject_unauthorized_connection
    end
  end
end
