Rails.application.routes.draw do
  resources :works
  resources :users, only: %i[index show]

  post '/upvote/:id', to: 'users#upvote', as: 'upvote'
  get '/login', to: 'users#login_form', as: 'login'
  post '/login', to: 'users#login'
  post '/logout', to: 'users#logout', as: 'logout'
end
