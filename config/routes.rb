Rails.application.routes.draw do
  root 'landing#index'

  get 'sessions/login', to: 'sessions#new'
  post 'sessions/login', to: 'sessions#login', as: 'login'
  delete 'sessions/logout', to: 'sessions#destroy'
  post 'sessions/logout', to: 'sessions#destroy', as: 'logout'

  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  resources :works

  resources :users, only: [:index, :show, :new]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end