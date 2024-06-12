class InputLabelComponent < ViewComponent::Base
  erb_template <<~ERB
    <a <%= sanitize @attributes.join(" ") %>>
      <%= @value ? @value : content %>
    </a>
  ERB

  def initialize(attributes = {})
    @value = attributes[:value] || nil
    attributes[:class] = "block font-medium text-sm text-gray-700 dark:text-gray-300#{" #{attributes[:class]}" if attributes[:class]}"
    @attributes = attributes.without(:value).map { |key, attribute| "#{key}=\"#{attribute}\"" }
  end
end
