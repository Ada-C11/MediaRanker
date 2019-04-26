Rails.application.routes.draw do
  root "homepages#index"

  resources :works do 
    post "/upvote", to: 'upvotes#upvote', as: 'upvote'
  end
  
  # user routes
  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
