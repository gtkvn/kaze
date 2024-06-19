class UpdateProfileInformationForm < ApplicationForm
  attr_accessor :name, :email

  validates :name,  presence: true
  validates :email, presence: true, lowercase: true, email: true, uniqueness: { model: User, attribute: :email, conditions: -> { where.not(id: Current.auth.user.id) } }

  def update
    Current.auth.user.name = name
    Current.auth.user.email = email
    Current.auth.user.email_verified_at = nil if Current.auth.user.changed.include?('email')

    Current.auth.user.save
  end
end
