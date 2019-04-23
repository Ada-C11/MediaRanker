Rails.application.routes.draw do

  root 'homepages#index'

  # get '/homepages#top_ten_books'
  # get '/homepages#top_ten_movies'
  # get '/homepages#top_ten_albums'

  resources :works
  resources :users



  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
