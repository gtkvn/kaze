class Kaze::Commands::App::StackFactory
  def self.make(stack)
    raise Kaze::Commands::InvalidStackError, "Invalid stack. Supported stacks are #{AVAILABLE_STACKS.keys.map { |k| "[#{k}]" }.join(', ')}." unless AVAILABLE_STACKS.key?(stack)

    Object.const_get("Kaze::Commands::App::#{AVAILABLE_STACKS[stack].split(/_/).map(&:capitalize).join}Stack").new
  end
end
