Rails.application.routes.draw do
  root to: "homepages#index"

  resources :users
  resources :works
  resources :votes
  resources :homepages

  resources :users do
    resources :votes
  end

  resources :works do
    resources :votes
  end
end
