require 'thor'

THOR = Thor.new

AVAILABLE_STACKS = {
  hotwire: 'hotwire',
  react: 'inertia_react',
  vue: 'inertia_vue'
}

class Kaze::Commands::App < Thor
  def self.exit_on_failure?() true end

  desc 'install [STACK]', 'Install the Kaze controllers and resources. Supported stacks: hotwire, react, vue.'
  def install(stack = 'hotwire')
    return say 'Kaze must be run in a new Rails application.', :red unless File.exist?("#{Dir.pwd}/bin/rails")

    StackFactory.make(stack.to_sym).install
  rescue Kaze::Commands::InvalidStackError
    say "Invalid stack. Supported stacks are #{AVAILABLE_STACKS.keys.map { |k| "[#{k}]" }.join(', ')}.", :red
  end

  desc 'version', 'Show Kaze version'
  def version
    puts Kaze::VERSION
  end
end
