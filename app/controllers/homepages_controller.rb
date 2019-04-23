class HomepagesController < ApplicationController

  def index
    @works = Work.all.sort_by(&:id)
    @spotlight = @works.sample
    top_ten_movies
    top_ten_books
    top_ten_albums
  end
  
  def top_ten_movies
    @movies = Work.where(category: "movie")
    @top_ten_movies = @movies.sample(10)
  end

  def top_ten_books
    @books = Work.where(category: "book")
    @top_ten_books = @books.sample(10)
  end

  def top_ten_albums  
    @albums = Work.where(category: "album")
    @top_ten_albums = @albums.sample(10)
  end

end
