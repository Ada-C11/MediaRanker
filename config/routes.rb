Rails.application.routes.draw do
  get 'homepages/index'
  root to: "homepages#index" # where do i want this to be
  resources :users
  resources :works
  resources :votes, only: [:create] # maybe
end
