class Auth::RegisterForm < ApplicationForm
  attr_accessor :name, :email, :password, :password_confirmation

  validates :name, presence: true
  validates :email, presence: true, lowercase: true, email: true, uniqueness: { model: User, attribute: :email }
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end
