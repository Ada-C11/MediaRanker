Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  root 'landing#index'

  resources :works
  resources :users, only: [:index, :show, :new]
end