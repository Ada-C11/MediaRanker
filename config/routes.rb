Rails.application.routes.draw do
  get "home/index"
  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
