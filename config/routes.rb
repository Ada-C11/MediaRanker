Rails.application.routes.draw do
  root 'landing#index'

  get 'sessions/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#login'
  post 'sessions/logout', to: 'sessions#destroy', as: 'logout'

  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  resources :works

  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end