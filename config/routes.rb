Rails.application.routes.draw do
  # update to homepage once done
  root to: "works#index"

  resources :works
end
