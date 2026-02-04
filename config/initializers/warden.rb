Warden::Manager.after_set_user do |user, auth, opts|
  user.update_column(:online, true)
end

Warden::Manager.before_logout do |user, auth, opts|
  user.update_column(:online, false) if user
end
