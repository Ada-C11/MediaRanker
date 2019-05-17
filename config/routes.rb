Rails.application.routes.draw do
  root 'mainpages#index'
  resources :works
  post 'works/:id/upvote', to: 'works#upvote', as: 'upvote'
  resources :users, only: %i[index show]
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
  get '/users/current', to: 'users#current', as: 'current_user'
end
