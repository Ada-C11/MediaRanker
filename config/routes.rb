Rails.application.routes.draw do

  root "home#index"
  resources :home, only: :index
  # get 'works/index'
  # get 'works/show'
  # get 'works/new'
  # get 'works/create'
  # get 'works/edit'
  # get 'works/update'
  # get 'works/delete'
  # get 'works/category:string'
  # get 'works/title:string'
  # get 'works/author:string'
  # get 'works/publication_year:integer'
  # get 'works/description:string'
  # root "homepages#index"

  resources :works do
    resources :votes
  end

  resources :users 
  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
  get "/users/current", to: "users#current", as: "current_user"

  resources :votes

end
