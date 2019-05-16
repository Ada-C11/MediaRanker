Rails.application.routes.draw do
  root "pages#index"

  resources :works

  get "/users/current", to: "users#current_user", as: "current_user"

  resources :users, except: [:new, :create]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

  post "/works/:id/vote", to: "votes#add_vote", as: "vote_work"
end
