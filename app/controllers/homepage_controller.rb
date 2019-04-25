class HomepageController < ApplicationController
  def index
    movies = Work.where(category: "movie")
    @top_10_movies = movies.sample(10)

    albums = Work.where(category: "album")
    @top_10_albums = albums.sample(10)

    books = Work.where(category: "book")
    @top_10_books = books.sample(10)
  end
end
