Rails.application.routes.draw do
  root "homepage#index"
  get "/", to: "homepages#index"
  
  resources :works, :users, :votes

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  post '/works/:work_id/votes', to: 'votes#create', as: 'create_vote'
end
