module Kaze::Commands::InstallsInertiaStacks
  private

  def install_inertia_react_stack
    # Gems...
    return unless remove_gems([ "sprockets-rails" ])
    return unless install_gems([ "propshaft", "tailwindcss-rails", "inertia_rails", "vite_rails", "dotenv", "bcrypt", "js-routes" ])

    # NPM Packages...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/package.json", "#{Dir.pwd}/package.json")

    # Controllers...
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/app/controllers", "#{Dir.pwd}/app/controllers")

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
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/app/views/layouts/application.html.erb", "#{Dir.pwd}/app/views/layouts/application.html.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.html.erb", "#{Dir.pwd}/app/views/layouts/mailer.html.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.text.erb", "#{Dir.pwd}/app/views/layouts/mailer.text.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/user_mailer/reset_password.html.erb", "#{Dir.pwd}/app/views/user_mailer/reset_password.html.erb")

    # Components + Pages...
    ensure_directory_exists("#{Dir.pwd}/app/javascript")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/app/javascript", "#{Dir.pwd}/app/javascript")

    # Tests...

    # Routes...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/config/routes.rb", "#{Dir.pwd}/config/routes.rb")

    # Migrations...
    install_migrations

    # Tailwind / Vite...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.css", "#{Dir.pwd}/app/assets/stylesheets/application.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.tailwind.css", "#{Dir.pwd}/app/assets/stylesheets/application.tailwind.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/config/tailwind.config.js", "#{Dir.pwd}/config/tailwind.config.js")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/config/vite.json", "#{Dir.pwd}/config/vite.json")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/tsconfig.json", "#{Dir.pwd}/tsconfig.json")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-react-ts/vite.config.ts", "#{Dir.pwd}/vite.config.ts")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/bin/dev", "#{Dir.pwd}/bin/dev")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/bin/vite", "#{Dir.pwd}/bin/vite")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/Procfile.dev", "#{Dir.pwd}/Procfile.dev")
    run_command("rails generate js_routes:middleware")

    say ""
    say "Installing and building Node dependencies.", :magenta

    if File.exist?("#{Dir.pwd}/pnpm-lock.yaml")
      run_commands([ "pnpm install", "pnpm run build" ])
    elsif File.exist?("#{Dir.pwd}/yarn.lock")
      run_commands([ "yarn install", "yarn build" ])
    elsif File.exist?("#{Dir.pwd}/bun.lockb")
      run_commands([ "bun install", "bun run build" ])
    else
      run_commands([ "npm install", "npm run build" ])
    end

    say ""
    say "Kaze scaffolding installed successfully.", :green
  end

  def install_inertia_vue_stack
    # Gems...
    return unless remove_gems([ "sprockets-rails" ])
    return unless install_gems([ "propshaft", "tailwindcss-rails", "inertia_rails", "vite_rails", "dotenv", "bcrypt", "js-routes" ])

    # NPM Packages...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/package.json", "#{Dir.pwd}/package.json")

    # Controllers...
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/app/controllers", "#{Dir.pwd}/app/controllers")

    # Models...
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/models", "#{Dir.pwd}/app/models")

    # Forms...
    ensure_directory_exists("#{Dir.pwd}/app/forms")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/forms", "#{Dir.pwd}/app/forms")

    # Validators...
    ensure_directory_exists("#{Dir.pwd}/app/validators")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/validators", "#{Dir.pwd}/app/validators")

    # Views...
    ensure_directory_exists("#{Dir.pwd}/app/views/layouts")
    ensure_directory_exists("#{Dir.pwd}/app/views/user_mailer")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/app/views/layouts/application.html.erb", "#{Dir.pwd}/app/views/layouts/application.html.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.html.erb", "#{Dir.pwd}/app/views/layouts/mailer.html.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/layouts/mailer.text.erb", "#{Dir.pwd}/app/views/layouts/mailer.text.erb")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/views/user_mailer/reset_password.html.erb", "#{Dir.pwd}/app/views/user_mailer/reset_password.html.erb")

    # Mailers...
    ensure_directory_exists("#{Dir.pwd}/app/mailers")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/default/app/mailers", "#{Dir.pwd}/app/mailers")

    # Components + Pages...
    ensure_directory_exists("#{Dir.pwd}/app/javascript")
    FileUtils.copy_entry("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/app/javascript", "#{Dir.pwd}/app/javascript")

    # Tests...

    # Routes...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/config/routes.rb", "#{Dir.pwd}/config/routes.rb")

    # Migrations...
    install_migrations

    # Tailwind / Vite...
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.css", "#{Dir.pwd}/app/assets/stylesheets/application.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/app/assets/stylesheets/application.tailwind.css", "#{Dir.pwd}/app/assets/stylesheets/application.tailwind.css")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/config/tailwind.config.js", "#{Dir.pwd}/config/tailwind.config.js")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/config/vite.json", "#{Dir.pwd}/config/vite.json")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/tsconfig.json", "#{Dir.pwd}/tsconfig.json")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-vue-ts/vite.config.ts", "#{Dir.pwd}/vite.config.ts")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/default/bin/dev", "#{Dir.pwd}/bin/dev")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/bin/vite", "#{Dir.pwd}/bin/vite")
    FileUtils.copy_file("#{File.dirname(__FILE__)}/../../../stubs/inertia-common/Procfile.dev", "#{Dir.pwd}/Procfile.dev")
    run_command("rails generate js_routes:middleware")

    say ""
    say "Installing and building Node dependencies.", :magenta

    if File.exist?("#{Dir.pwd}/pnpm-lock.yaml")
      run_commands([ "pnpm install", "pnpm run build" ])
    elsif File.exist?("#{Dir.pwd}/yarn.lock")
      run_commands([ "yarn install", "yarn build" ])
    elsif File.exist?("#{Dir.pwd}/bun.lockb")
      run_commands([ "bun install", "bun run build" ])
    else
      run_commands([ "npm install", "npm run build" ])
    end

    say ""
    say "Kaze scaffolding installed successfully.", :green
  end
end
