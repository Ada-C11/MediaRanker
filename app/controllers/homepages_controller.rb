class HomepagesController < ApplicationController
  def index
    @spotlight = Work.all.sample
    puts top_ten_movies
    top_ten_books
    top_ten_albums
  end

  def top_ten_movies
    @movies = Work.all.where(category: "movie")
    @top_ten_movies = @movies.sample(10)
  end

  def top_ten_albums
    @albums = Work.all.where(category: "album")
    @top_ten_albums = @albums.sample(10)
  end

  def top_ten_books
    @books = Work.all.where(category: "book")
    @top_ten_books = @books.sample(10)
  end
end
