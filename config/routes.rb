Rails.application.routes.draw do
  resources :works
  resources :users, except: [:edit, :update]
end
