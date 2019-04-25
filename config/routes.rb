Rails.application.routes.draw do
  root to: 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/works', to: 'works#index', as: 'works'
  # get '/works/new', to: 'works#new', as: 'new_work'

  resources :works
end
