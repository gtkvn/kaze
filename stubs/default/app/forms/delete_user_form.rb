class DeleteUserForm < ApplicationForm
  attr_accessor :password

  validates :password, presence: true, current_password: true
end
