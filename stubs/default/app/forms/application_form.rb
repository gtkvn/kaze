class ApplicationForm
  include ActiveModel::Model

  def error_messages
    messages = {}
    errors.each { |error| messages[error.attribute] = error.message unless messages.has_key?(error.attribute) }
    messages
  end
end
