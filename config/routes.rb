Rails.application.routes.draw do
  root 'mainpages#index'
  resources :works
end
