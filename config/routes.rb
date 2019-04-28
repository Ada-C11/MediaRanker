Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "works#top_media"

  get "/works", to: "works#index", as: "list_of_works"

  resources :works

  resources :users

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"

  get "/works/:id/vote", to: "votes#upvote", as: "upvote"
  post "/works/:id/vote", to: "votes#upvote"
end
