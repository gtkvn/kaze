class LowercaseValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, (options[:message] || "must be lowercase") unless value == value.downcase
  end
end
