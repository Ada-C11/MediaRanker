Rails.application.routes.draw do
  root "homepages#index"

  resources :works
  # will need a nested route for upvotes

  # user routes
  resources :users, only: [:index, :show]
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
