Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "works#top"
  resources :works
  resources :users, only: [:index, :show, :create]

  resources :works do
    # route is work_votes_path
    resources :votes, only: [:create]
  end

  get "/login", to: "users#login_form", as: "login"
  post "/login", to: "users#login"
  post "/logout", to: "users#logout", as: "logout"
end
