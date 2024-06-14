class UpdateProfileInformationForm < ApplicationForm
  attr_accessor :name, :email

  validates :name,  presence: true
  validates :email, presence: true, lowercase: true, email: true, uniqueness: { model: User, attribute: :email, conditions: -> { where.not(id: Current.auth.user.id) } }
end
