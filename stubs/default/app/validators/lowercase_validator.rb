class LowercaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    value = '' if value.nil?
    record.errors.add attribute, (options[:message] || 'must be lowercase') unless value == value.downcase
  end
end
