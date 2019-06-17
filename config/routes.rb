Rails.application.routes.draw do
  root "home#index"

  get "sessions/login", to: "sessions#new"
  post "sessions/login", to: "sessions#login", as: "login"
  delete "sessions/destroy", to: "sessions#destroy", as: "logout"

  resources :works
  post "works/:id/upvote", to: "works#upvote", as: "upvote"

  resources :users, only: [:index, :show]
end
