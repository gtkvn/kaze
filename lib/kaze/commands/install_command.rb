require "bundler"
require "fileutils"
require "open3"
require "thor"

class Kaze::Commands::InstallCommand < Thor
  include Kaze::Commands::InstallInertiaStacks

  desc "install [STACK]", "Install the Kaze controllers and resources. Supported stacks: react, vue."
  def install(stack = "hotwire")
    if stack == "react"
      return install_inertia_react_stack
    end

    if stack == "vue"
      return install_inertia_vue_stack
    end

    say "Invalid stack. Supported stacks are [react], [vue].", :red
  end

  private

  def require_gems(gems = [])
    installed_gems = Bundler::Definition.build("#{Dir.pwd}/Gemfile", nil, {}).dependencies.map(&:name)

    installing_gems = gems.map { |gem| gem unless installed_gems.include?(gem) }.compact

    return true if installing_gems.empty?

    status = run_command("bundle add #{installing_gems.join(" ")}")

    status.success?
  end

  def install_migrations
    ensure_directory_exists("#{Dir.pwd}/db/migrate")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/db/migrate", "#{Dir.pwd}/db/migrate")
    stdin, _ = Open3.capture3("rails version")
    versions = stdin.gsub!("Rails ", "").split(".")
    Open3.capture3('grep -rl ActiveRecord::Migration$ db | xargs sed -i "" "s/ActiveRecord::Migration/ActiveRecord::Migration[' + [ versions[0], versions[1] ].join(".") + ']/g"')
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
