class UserMailer < ApplicationMailer
  def reset_password
    @reset_url = password_reset_url(token: params[:token])

    mail(
      to: params[:user].email,
      subject: 'Reset Password Notification'
    )
  end

  def verify_email
    @verification_url = verification_verify_url(id: params[:user].id, hash: Digest::SHA1.hexdigest(params[:user].email))

    mail(
      to: params[:user].email,
      subject: 'Verify Email Address'
    )
  end
end
