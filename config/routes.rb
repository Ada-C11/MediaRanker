Rails.application.routes.draw do
  get "homepages/index"
  root to: "homepages#index" # where do i want this to be
  resources :users, only: [:show, :index]
  resources :works do
    resources :votes, only: [:create]
  end

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/current", to: "users#current", as: "current_user"
end
