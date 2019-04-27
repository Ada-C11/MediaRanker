Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homepages#index"
  resources :homepages, only: :index

  resources :works, only: [:index, :new, :create, :show, :edit]
end
