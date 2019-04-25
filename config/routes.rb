Rails.application.routes.draw do
  root "homepages#index"

  resources :works
  # will need a nested route for upvotes

  # user routes
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
