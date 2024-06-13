require 'bundler'
require 'fileutils'
require 'open3'
require 'thor'

class Kaze::Commands::InstallCommand < Thor
  include Kaze::Commands::InstallsHotwireStack
  include Kaze::Commands::InstallsInertiaStacks

  desc 'install [STACK]', 'Install the Kaze controllers and resources. Supported stacks: hotwire, react, vue.'
  def install(stack = 'hotwire')
    if stack == 'hotwire'
      return install_hotwire_stack
    end

    if stack == 'react'
      return install_inertia_react_stack
    end

    if stack == 'vue'
      return install_inertia_vue_stack
    end

    say 'Invalid stack. Supported stacks are [hotwire], [react], [vue].', :red
  end

  private

  def install_gems(gems = [], group = nil)
    installed_gems = Bundler::Definition.build("#{Dir.pwd}/Gemfile", nil, {}).dependencies.map(&:name)

    gem_being_installed = gems.map { |gem| gem unless installed_gems.include?(gem) }.compact

    return true if gem_being_installed.empty?

    status = run_command("bundle add #{gem_being_installed.join(" ")}#{group ? " --group \"#{group}\"" : ""}")

    status.success?
  end

  def remove_gems(gems = [])
    installed_gems = Bundler::Definition.build("#{Dir.pwd}/Gemfile", nil, {}).dependencies.map(&:name)

    gems_being_removed = gems.map { |gem| gem if installed_gems.include?(gem) }.compact

    return true if gems_being_removed.empty?

    status = run_command("bundle remove #{gems_being_removed.join(" ")}")

    status.success?
  end

  def install_migrations
    ensure_directory_exists("#{Dir.pwd}/db/migrate")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/db/migrate", "#{Dir.pwd}/db/migrate")
    stdin, _ = Open3.capture3('rails version')
    versions = stdin.gsub!('Rails ', '').split('.')
    railsVersion = [ versions[0], versions[1] ].join('.')
    Dir.children("#{Dir.pwd}/db/migrate").each do |file|
      path = "#{Dir.pwd}/db/migrate/#{file}"
      File.write(path, File.read(path).gsub!(/ActiveRecord::Migration$/, "ActiveRecord::Migration[#{railsVersion}]"))
    end
  end

  def ensure_directory_exists(path)
    FileUtils.mkdir_p(path) unless File.directory?(path)
  end

  def run_command(command)
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      Thread.new do
        stdout.each { |line| say line }
      end
      Thread.new do
        stderr.each { |line| say line, :red }
      end
      wait_thr.value
    end
  end

  def run_commands(commands)
    commands.each { |command| run_command(command) }
  end
end
