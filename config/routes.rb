Rails.application.routes.draw do
  root 'landing#index'
  resources :works

  resources :users, only: [:index, :show, :new]

  get 'sessions/login', to: 'sessions#new'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  post '/logout', to: 'sessions#logout', as: 'logout'

  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end