class Kaze::Commands::App::StackFactory
  def self.make(stack)
    raise Kaze::Commands::InvalidStackError unless AVAILABLE_STACKS.key?(stack)

    Object.const_get("Kaze::Commands::App::#{AVAILABLE_STACKS[stack].split(/_/).map(&:capitalize).join}Stack").new
  end
end
