Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "homepages#index"
  get "/", to: "homepages#index"
  resources :works, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :works do
    resources :votes, only: [:create]
  end

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"

  # post "/logout", to: "users#logout", as: "logout"
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  get "/users/current", to: "users#current", as: "current_user"

  resources :users, only: [:index, :show]
end
