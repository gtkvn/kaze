class UserMailer < ApplicationMailer
  def reset_password(token)
    @reset_url = password_reset_url(token: token)

    mail(
      to: params[:user].email,
      subject: 'Reset Password Notification'
    )
  end

  def verify_email
    verifier = ActiveSupport::MessageVerifier.new(ENV.fetch('RAILS_MASTER_KEY', ''))

    signature = verifier.generate(verification_verify_url(id: params[:user].id, hash: Digest::SHA1.hexdigest(params[:user].email)), expires_in: 60.minutes.from_now.to_i)

    @verification_url = verification_verify_url(id: params[:user].id, hash: Digest::SHA1.hexdigest(params[:user].email), signature: signature)

    mail(
      to: params[:user].email,
      subject: 'Verify Email Address'
    )
  end
end
