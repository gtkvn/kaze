class Kaze::Commands::VersionCommand < Thor
  desc 'version', 'Show Kaze version'
  def version
    puts Kaze::VERSION
  end
end
