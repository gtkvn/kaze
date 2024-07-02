require 'bundler'
require 'fileutils'
require 'open3'

class Kaze::Commands::App::BaseStack
  def install
    raise NotImplementedError
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
    stdin, _ = Open3.capture3("#{Dir.pwd}/bin/rails version")
    versions = stdin.gsub!('Rails ', '').split('.')
    railsVersion = [ versions[0], versions[1] ].join('.')

    ensure_directory_exists("#{Dir.pwd}/db/migrate")
    FileUtils.copy_entry("#{stubs_path}/default/db/migrate", "#{Dir.pwd}/db/migrate")
    Dir.children("#{Dir.pwd}/db/migrate").each { |file| replace_in_file(/ActiveRecord::Migration$/, "ActiveRecord::Migration[#{railsVersion}]", "#{Dir.pwd}/db/migrate/#{file}") }
  end

  def install_tests
    ensure_directory_exists("#{Dir.pwd}/test/factories")
    ensure_directory_exists("#{Dir.pwd}/test/integration")
    FileUtils.copy_file("#{stubs_path}/default/test/test_helper.rb", "#{Dir.pwd}/test/test_helper.rb")
    FileUtils.copy_entry("#{stubs_path}/default/test/factories", "#{Dir.pwd}/test/factories")
    FileUtils.copy_entry("#{stubs_path}/default/test/integration", "#{Dir.pwd}/test/integration")
  end

  def ensure_directory_exists(path)
    FileUtils.mkdir_p(path) unless File.directory?(path)
  end

  def replace_in_file(search, replace, path)
    File.write(path, File.read(path).gsub!(search, replace))
  end

  def run_command(command)
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      stdout_thread = Thread.new do
        while line = stdout.gets do
          say line
        end
      end
      stderr_thread = Thread.new do
        while line = stderr.gets do
          say line, :red
        end
      end
      stdout_thread.join
      stderr_thread.join
      wait_thr.value
    end
  end

  def run_commands(commands)
    commands.each { |command| run_command(command) }
  end

  def say(message, color = nil)
    THOR.say(message, color)
  end

  def stubs_path
    "#{File.dirname(__FILE__)}/../../../../stubs"
  end
end
