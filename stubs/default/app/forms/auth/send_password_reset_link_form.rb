class Auth::SendPasswordResetLinkForm < ApplicationForm
  attr_accessor :email

  validates :email, presence: true, email: true

  def send_reset_link?
    return false if invalid?

    user = User.find_by(email: @email)

    if user.nil?
      errors.add(:email, message: "We can't find a user with that email address.")
      return false
    end

    user.send_password_reset_notification(user.generate_token_for(:password_reset))

    true
  end
end
