Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "homepages#index"
  get "/", to: "homepages#index"
  resources :works, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  get "/users/current", to: "users#current", as: "current_user"
  post "/logout", to: "users#logout", as: "logout"
end
