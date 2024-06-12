class InputErrorComponent < ViewComponent::Base
  erb_template <<~ERB
    <div <%= sanitize @attributes.join(" ") %>>
      <p class="text-sm text-red-600 dark:text-red-400">
        <%= @message %>
      </p>
    </div>
  ERB

  def initialize(attributes = {})
    @message = attributes[:message]
    @attributes = attributes.without(:message).map { |key, attribute| "#{key}=\"#{attribute}\"" }
  end

  def render?
    @message.present?
  end
end
