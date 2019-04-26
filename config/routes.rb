Rails.application.routes.draw do

  root to: 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :works 
  resources :users
  post '/vote', to: 'votes#create', as: 'create_vote'

  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'

  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: 'current_user'
end
