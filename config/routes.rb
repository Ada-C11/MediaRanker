Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :works
  resources :users, except: [:edit, :update, :destroy]
  resources :votes, only: [:index, :create]
end
