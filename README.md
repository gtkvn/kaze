# Kaze

Heavily inspired by [Laravel Breeze](https://github.com/laravel/breeze), this gem offers authentication and application starter kits to give you a head start building your new Rails application. These kits automatically scaffold your application with the routes, controllers, and views you need to register and authenticate your application's users.

[Kaze](https://github.com/gtkvn/kaze) is a minimal, simple implementation of all of Rails's authentication features, including login, registration, password reset. In addition, Kaze includes a simple "profile" page where the user may update their name, email address, and password.

Kaze provides scaffolding options based on Inertia, with the choice of using Vue or React for the Inertia-based scaffolding.

## Installation

First, you should create a new Rails application, configure your database, and run your database migrations.

You may install Kaze globally with:

```
gem install kaze
```

Once Kaze is installed, you may scaffold your application using one of the Kaze "stacks" discussed in the documentation below.

## Kaze & Hotwire

The default Kaze "stack" is the Hotwire stack. Hotwire is a powerful way to building dynamic, reactive, front-end UIs primarily using Ruby and ERB templates without using much JavaScript by sending HTML instead of JSON over the wire.

The Hotwire stack may be installed by invoking the `install` command with no other additional arguments inside your app directory.

```
kaze install
```

After Kaze's scaffolding is installed, you may start your application:

```
bin/setup
bin/dev
```

Next, you may navigate to your application's `/login` or `/register` URLs in your web browser.

## Kaze & React / Vue

Kaze offers React and Vue scaffolding via an Inertia frontend implementation. Inertia allows you to build modern, single-page React and Vue applications using classic server-side routing and controllers.

Inertia lets you enjoy the frontend power of React and Vue combined with the incredible backend productivity of Rails and lightning-fast Vite compilation. To use an Inertia stack, specify vue or react as your desired stack when executing the `install` command inside your app directory:

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

Next, you may navigate to your application's `/login` or `/register` URLs in your web browser.
