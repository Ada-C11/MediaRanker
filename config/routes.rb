Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"
  resources :works do
    resources :votes, only: [:create]
  end
  resources :users, only: [:index, :show]

  get "/auth/github", as: "github_login"
  get "/auth/:provider/callback", to: "users#create"
  delete "/logout", to: "users#destroy", as: "logout"
  #post "/works/:id/upvote", to: "works#upvote", as: "upvote"
  #resources :users, only: [:index, :new, :create]
  # get "/login", to: "users#login_form", as: "login"
  # post "/login", to: "users#login"
  # post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"
end
