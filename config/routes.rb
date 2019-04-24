Rails.application.routes.draw do

  root 'homepages#index', as: 'home'

  resources :works
  resources :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
