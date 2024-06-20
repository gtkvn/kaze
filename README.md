<p align="center"><img src="/art/logo.svg" alt="Logo Kaze"></p>

# Kaze

Heavily inspired by [Laravel Breeze](https://github.com/laravel/breeze), this gem offers authentication and application starter kits to give you a head start building your new Rails application. These kits automatically scaffold your application with the routes, controllers, and views you need to register and authenticate your application's users.

[Kaze](https://github.com/gtkvn/kaze) is a opinionated minimal, simple implementation of all authentication features that a modern web application should have, including login, registration, password reset, email verification. In addition, Kaze includes a simple "profile" page where the user may update their name, email address, and password.

Kaze provides scaffolding options based on [Hotwire](https://hotwired.dev) or [Inertia](https://inertiajs.com), with the choice of using Vue or React for the Inertia-based scaffolding.

## Installation

Before creating your first project powered by Kaze, make sure that your local machine has Ruby and [Rails](https://rubyonrails.org) installed. Ruby can be installed in minutes via [mise](https://mise.jdx.dev).

```
mise use -g ruby@3.3
```

After you have installed Ruby, you may install Rails and Kaze globally:

```
gem install rails
gem install kaze
```

Then, you may create a new Rails application:

```
rails new kaze-example-app
cd kaze-example-app
```

Once the project has been created, you may scaffold your application using one of the Kaze "stacks" discussed in the documentation below.

### Kaze and Hotwire

The default Kaze "stack" is the Hotwire stack. Hotwire is a powerful way to building dynamic, reactive, front-end UIs primarily using Ruby and ERB templates without using much JavaScript by sending HTML instead of JSON over the wire.

The Hotwire stack may be installed by invoking the `kaze install` command with no other additional arguments inside your app directory. This command publishes the authentication, views, routes, controllers, and other resources to your application.

```
kaze install
```

After Kaze's scaffolding is installed, you may start your application:

```
bin/setup
bin/dev
```

Next, you may navigate to your application's `/login` or `/register` URLs in your web browser. All of Kaze's routes are defined within the `config/routes.rb` file.

## Kaze and React / Vue

Kaze offers React and Vue scaffolding via an Inertia frontend implementation. Inertia allows you to build modern, single-page React and Vue applications using classic server-side routing and controllers.

Inertia lets you enjoy the frontend power of React and Vue combined with the incredible backend productivity of Rails and lightning-fast Vite compilation. To use an Inertia stack, specify `react` or `vue` as your desired stack when executing the `kaze install` command:

```
kaze install react

# Or...

kaze install vue
```

After Kaze's scaffolding is installed, you may start your application:

```
bin/setup
bin/dev
```

Next, you may navigate to your application's `/login` or `/register` URLs in your web browser. All of Kaze's routes are defined within the `config/routes.rb` file.
