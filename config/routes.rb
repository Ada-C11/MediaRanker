Rails.application.routes.draw do
  root "home#index"

  get "sessions/login", to: "sessions#new"
  post "sessions/login", to: "sessions#login", as: "login"
  delete "sessions/destroy", to: "sessions#destroy", as: "logout"

  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
