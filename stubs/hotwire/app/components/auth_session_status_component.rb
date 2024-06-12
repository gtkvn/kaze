class AuthSessionStatusComponent < ViewComponent::Base
  erb_template <<~ERB
    <div <%= sanitize @attributes.join(" ") %>>
      <%= @status %>
    </div>
  ERB

  def initialize(attributes = {})
    @status = attributes[:status]
    attributes[:class] = "font-medium text-sm text-green-600 dark:text-green-400#{" #{attributes[:class]}" if attributes[:class]}"
    @attributes = attributes.without(:status).map { |key, attribute| "#{key}=\"#{attribute}\"" }
  end

  def render?
    @status.present?
  end
end
