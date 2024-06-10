class UpdatePasswordForm < ApplicationForm
  attr_accessor :current_password, :password, :password_confirmation

  validates :current_password, presence: true, current_password: true
  validates :password, presence: true, confirmation: true, length: { minimum: 8 }
end
