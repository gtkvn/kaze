module CanResetPassword
  def send_password_reset_notification(token)
    UserMailer.with(user: self, token: token).reset_password.deliver_later
  end
end
