Rails.application.routes.draw do
  root to: "homepages#index"
  resources :works
  resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: :login_user
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: :logout_user
end
