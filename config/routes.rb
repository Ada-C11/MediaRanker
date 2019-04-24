
Rails.application.routes.draw do
  get 'sessions/login', to: 'sessions#new'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  delete 'sessions/destroy', to: 'sessions#destroy', as: 'logout'

  get 'users/index', to: 'users#index', as: 'users'
  get 'users/show', to: 'users#show', as: 'user'

  root 'landing#index'
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'

  resources :works
  resources :users, only: [:index, :show, :new]
end