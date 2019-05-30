Rails.application.routes.draw do
  root "home#index"
  resources :works
  resources :users, only: [:index, :show, :new, :create]
end
