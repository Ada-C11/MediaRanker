Rails.application.routes.draw do
  root to: "homepages#index"
  resources :homepages, only: [:index]

  resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  # get "/users/current", to: "users#current", as: "current_user"
  # get "/users", to: "users#index", as: "users"
  # get "/users/:id", to: "users#show", as: "user"

  resources :works do
    resources :votes, only: [:create]
  end
  # post "/works/:id/upvote", to: "works#upvote", as: "upvote"

  # resources :votes, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
