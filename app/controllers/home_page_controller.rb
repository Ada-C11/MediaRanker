class HomePageController < ApplicationController
  def index
    @books = Work.books.order("lower(publication_year
      ) DESC")
    # @albums = Work.albums.order("lower(publication_year
    #     ) DESC")
    # @movies = Work.movies.order("lower(publication_year
    #       ) DESC")
  end
end
