Rails.application.routes.draw do
  root 'homepages#index'
  resources :works
  resources :homepages
end
