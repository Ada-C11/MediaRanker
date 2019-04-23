Rails.application.routes.draw do
  get 'users/index'
  get 'users/show'
  # update to homepage once done
  root to: "works#index"

  resources :works
end
