Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  root "welcome#index"

  get "register", to: "auth/registered_user#new", as: :register
  post "register", to: "auth/registered_user#create"

  get "login", to: "auth/authenticated_session#new", as: :login
  post "login", to: "auth/authenticated_session#create"

  get "forgot-password", to: "auth/password_reset_link#new", as: :password_request
  post "forgot-password", to: "auth/password_reset_link#create", as: :password_email

  get "reset-password/:token", to: "auth/new_password#new", as: :password_reset
  post "reset-password", to: "auth/new_password#create", as: :password_store

  post "logout", to: "auth/authenticated_session#destroy", as: :logout

  get "dashboard", to: "dashboard#index", as: :dashboard

  get "profile", to: "profile#edit", as: :profile_edit
  patch "profile", to: "profile#update", as: :profile_update
  delete "profile", to: "profile#destroy", as: :profile_destroy

  put "password", to: "password#update", as: :password_update
end
