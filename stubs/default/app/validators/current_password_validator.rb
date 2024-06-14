class CurrentPasswordValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, 'The password is incorrect.' unless Current.auth.user&.authenticate(value)
  end
end
