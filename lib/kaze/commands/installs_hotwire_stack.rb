module Kaze::Commands::InstallsHotwireStack
  private

  def install_hotwire_stack
    # Gems...
    return unless remove_gems([ 'sprockets-rails', 'stimulus-rails' ])
    return unless install_gems([ 'propshaft', 'view_component', 'tailwindcss-rails', 'turbo-rails', 'dotenv', 'bcrypt' ])
    return unless install_gems([ 'hotwire-livereload' ], 'development')

    # Controllers...
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/hotwire/app/controllers", "#{Dir.pwd}/app/controllers")

    # Models...
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/models", "#{Dir.pwd}/app/models")

    # Forms...
    ensure_directory_exists("#{Dir.pwd}/app/forms")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/forms", "#{Dir.pwd}/app/forms")

    # Validators...
    ensure_directory_exists("#{Dir.pwd}/app/validators")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/validators", "#{Dir.pwd}/app/validators")

    # Mailers...
    ensure_directory_exists("#{Dir.pwd}/app/mailers")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/mailers", "#{Dir.pwd}/app/mailers")

    # Views...
    ensure_directory_exists("#{Dir.pwd}/app/views/layouts")
    ensure_directory_exists("#{Dir.pwd}/app/views/user_mailer")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/hotwire/app/views", "#{Dir.pwd}/app/views")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.html.erb", "#{Dir.pwd}/app/views/layouts/mailer.html.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.text.erb", "#{Dir.pwd}/app/views/layouts/mailer.text.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/user_mailer/reset_password.html.erb", "#{Dir.pwd}/app/views/user_mailer/reset_password.html.erb")

    # Components + Pages...
    ensure_directory_exists("#{Dir.pwd}/app/components")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/hotwire/app/components", "#{Dir.pwd}/app/components")
    ensure_directory_exists("#{Dir.pwd}/app/javascript")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/hotwire/app/javascript", "#{Dir.pwd}/app/javascript")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/hotwire/config/importmap.rb", "#{Dir.pwd}/config/importmap.rb")

    # Tests...

    # Routes...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/config/routes.rb", "#{Dir.pwd}/config/routes.rb")

    # Migrations...
    install_migrations

    # Tailwind...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.css", "#{Dir.pwd}/app/assets/stylesheets/application.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.tailwind.css", "#{Dir.pwd}/app/assets/stylesheets/application.tailwind.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/hotwire/config/tailwind.config.js", "#{Dir.pwd}/config/tailwind.config.js")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/bin/dev", "#{Dir.pwd}/bin/dev")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/hotwire/Procfile.dev", "#{Dir.pwd}/Procfile.dev")
    run_command('rails tailwindcss:build')

    say ''
    say 'Kaze scaffolding installed successfully.', :green
  end
end
