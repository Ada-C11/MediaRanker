Rails.application.routes.draw do
  # get 'users/index'
  root to: 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/works', to: 'works#index', as: 'works'
  # get '/works/new', to: 'works#new', as: 'new_work'

  resources :works
  resources :users

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'

  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: 'current_user'
end
