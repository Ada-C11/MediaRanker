Rails.application.routes.draw do

  # get 'works/category:string'
  # get 'works/title:string'
  # get 'works/author:string'
  # get 'works/publication_year:integer'
  # get 'works/description:string'
  # root "homepages#index"

  resources :works do
    resources :votes
  end

  resources :users do
    resources :votes
    # , only: [:index, :new]
  end

  resources :votes

end
