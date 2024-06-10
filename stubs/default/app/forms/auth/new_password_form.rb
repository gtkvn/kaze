class Auth::NewPasswordForm < ApplicationForm
  attr_accessor :token, :password, :password_confirmation

  validates :token, presence: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }

  def reset?
    return false if invalid?

    user = User.find_by_token_for(:password_reset, token)

    if user.nil?
      errors.add(:password, message: "This password reset token is invalid.")
      return false
    end

    user.update(password: password)

    true
  end
end
