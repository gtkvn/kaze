module CanResetPassword
  def send_password_reset_notification(token)
    UserMailer.with(user: self).reset_password(token).deliver_later
  end
end
