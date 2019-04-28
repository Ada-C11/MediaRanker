Rails.application.routes.draw do

  root "home#index"
  resources :home, only: [:index]

  resources :works do
    resources :votes, only: [:create]
  end

  resources :users do
    resources :votes, only: [:create]
  end
  
  resources :votes, only: [:create]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"


end
