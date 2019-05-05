Rails.application.routes.draw do
  root "works#homepage", as: "home"

  resources :works #, except: [:destroy]

  resources :users
  # Why only index and new?
  # resources :books, only: [:index, :new]

  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"

end
