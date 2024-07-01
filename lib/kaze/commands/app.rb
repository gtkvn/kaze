require 'thor'

THOR = Thor.new

class Kaze::Commands::App < Thor
  def self.exit_on_failure?() true end

  desc 'install [STACK]', 'Install the Kaze controllers and resources. Supported stacks: hotwire, react, vue.'
  def install(stack = 'hotwire')
    return say 'Kaze must be run in a new Rails application.', :red unless File.exist?("#{Dir.pwd}/bin/rails")

    StackFactory.make(stack.to_sym).install
  rescue => e
    say e.message, :red
  end

  desc 'version', 'Show Kaze version'
  def version
    puts Kaze::VERSION
  end
end
