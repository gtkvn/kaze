class Kaze::Commands::App::StackFactory
  def self.make(stack)
    available_stacks = {
      hotwire: 'hotwire',
      react: 'inertia_react',
      vue: 'inertia_vue'
    }

    raise Kaze::Commands::InvalidStackError, "Invalid stack. Supported stacks are #{available_stacks.keys.map { |k| "[#{k}]" }.join(', ')}." unless available_stacks.key?(stack)

    Object.const_get("Kaze::Commands::App::#{available_stacks[stack].split(/_/).map(&:capitalize).join}Stack").new
  end
end
