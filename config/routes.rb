Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "works#top_works"

  resources :works

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current/:id", to: "users#current", as: "current_user"
  get "/users", to: "users#index", as: "users"

  post "/work/:id/upvote", to: "votes#upvote", as: "upvote"
end
