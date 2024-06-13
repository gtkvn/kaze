class UserMailer < ApplicationMailer
  def reset_password
    mail(
      to: params[:user].email,
      subject: 'Reset Password Notification'
    )
  end
end
