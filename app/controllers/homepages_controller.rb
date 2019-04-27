class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight
    @top_ten_movies = Work.top_ten_movies
    @top_ten_books = Work.top_ten_books
    @top_ten_albums = Work.top_ten_albums
  end

  # def top_ten_movies
  #   @movies = Work.where(category: "movie")
  #   @top_ten_movies = @movies.sort_by { |movie| movie.votes.length }.first(10)
  # end

  # def top_ten_albums
  #   @albums = Work.where(category: "album")
  #   @top_ten_albums = @albums.sort_by { |album| album.votes.length }.first(10)
  # end

  # def top_ten_books
  #   @books = Work.where(category: "book")
  #   @top_ten_books = @books.sort_by { |book| book.votes.length }.first(10)
  # end
end
