module MustVerifyEmail
  extend ActiveSupport::Concern

  def has_verified_email?
    !email_verified_at.nil?
  end

  def mark_email_as_verified
    self.update(email_verified_at: Time.now)
  end

  def send_email_verification_notification
    UserMailer.with(user: self).verify_email.deliver_later
  end
end
