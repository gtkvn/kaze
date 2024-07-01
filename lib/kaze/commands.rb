require 'bundler'
require 'fileutils'
require 'open3'
require 'thor'

module Kaze::Commands
  class App < Thor
    include InstallsHotwireStack
    include InstallsInertiaStacks
    include Utils

    def self.exit_on_failure?() true end

    desc 'install [STACK]', 'Install the Kaze controllers and resources. Supported stacks: hotwire, react, vue.'
    def install(stack = 'hotwire')
      return say 'Kaze must be run in a new Rails application.', :red unless File.exist?("#{Dir.pwd}/bin/rails")

      name = "install_#{available_stacks[stack.to_sym]}_stack"

      return send(name) if respond_to?(name, true)

      say "Invalid stack. Supported stacks are #{available_stacks.keys.map { |k| "[#{k}]" }.join(', ')}.", :red
    end

    desc 'version', 'Show Kaze version'
    def version
      puts Kaze::VERSION
    end

    private

    def available_stacks
      {
        hotwire: 'hotwire',
        react: 'inertia_react',
        vue: 'inertia_vue'
      }
    end
  end
end
