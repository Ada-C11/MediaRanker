Rails.application.routes.draw do
  root "homepages#index"

  resources :works
  # will need a nested route for upvotes

  # helper method for user routes
  user_routes
end
