Rails.application.routes.draw do
  root "works#homepage", as: "home"

  resources :works #, except: [:destroy]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :users
end
