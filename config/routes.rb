Rails.application.routes.draw do
  root "homepages#index"

  resources :works
  
  # will need a nested route for upvotes

end
