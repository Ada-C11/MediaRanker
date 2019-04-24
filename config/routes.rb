Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "works#index"
  resources :votes

  resources :works do
    resources :votes, only: [:index]
  end

  resources :users do
    resources :votes, only: [:index]
  end
end
