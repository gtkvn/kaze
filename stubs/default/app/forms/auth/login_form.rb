class Auth::LoginForm < ApplicationForm
  attr_accessor :email, :password

  validates :email, presence: true, email: true
  validates :password, presence: true

  def authenticate
    return nil if invalid?

    user = User.authenticate_by(email: email, password: password)

    return user if user.present?

    errors.add(:email, message: 'These credentials do not match our records.')

    nil
  end
end
