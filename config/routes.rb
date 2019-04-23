Rails.application.routes.draw do
  root 'homepages#index'

  resources :users
  resources :works
end
