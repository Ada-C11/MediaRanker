Rails.application.routes.draw do
  root to: "homepages#index"
  # get "votes/index"
  # get "votes/show"
  # get "works/index"
  # get "works/show"
  # get "users/index"
  # get "users/show"

  resources :works do
    resources :votes, only: [:create]
  end
  #don't just do votes, go back and see what specfic routes you need and only add them

  resources :users, only: [:index, :show]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  #get "/users/current", to: "users#current", as: "current_user"
  #copied and pasted from textbook curriculum but don't need?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
