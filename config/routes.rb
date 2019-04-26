Rails.application.routes.draw do
  # get 'works/new'
  # get 'works/create'
  # get 'works/show'

  root "homepages#index"

  resources :works

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
  get "/users", to: "users#index", as: "users"
  get "/user/:id", to: "users#show", as: "user"

  post "/works/:id", to: "votes#create", as: "vote"
end
