Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works
  resources :users, except: [:edit, :update, :destroy]
  resources :votes, only: [:index, :create]

  get "/login", to: "users#loginform", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
