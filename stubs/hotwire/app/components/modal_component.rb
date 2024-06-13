class ModalComponent < ViewComponent::Base
  def initialize(attributes = {})
    @name = attributes[:name]
    @show = attributes[:show] || false
    @max_width = {
      :sm => 'sm:max-w-sm',
      :md => 'sm:max-w-md',
      :lg => 'sm:max-w-lg',
      :xl => 'sm:max-w-xl',
      '2xl' => 'sm:max-w-2xl'
    }[attributes[:max_width] || '2xl']
    @attributes = attributes.without(:name, :show, :max_width)
  end
end
