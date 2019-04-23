Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'landing#index'
  resources :works
  resources :users, only: [:index, :show, :new]
end
