class Auth::LoginForm < ApplicationForm
  attr_accessor :email, :password

  validates :email, presence: true, email: true
  validates :password, presence: true

  def authenticate
    return if invalid?

    errors.add(:email, message: 'These credentials do not match our records.') unless Current.auth.attempt(email: email, password: password)
  end
end
