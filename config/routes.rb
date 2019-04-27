Rails.application.routes.draw do
  root to: "homepages#index"

  resources :works do
    resources :upvotes, only: [:create]
  end
  
  # user routes
  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"

end
