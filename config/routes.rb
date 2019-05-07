Rails.application.routes.draw do
  root 'homepages#index'

  resources :users
  resources :works
  resources :votes

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  post "/works/:id/upvote", to: "works#upvote", as: "upvote_work"
end
