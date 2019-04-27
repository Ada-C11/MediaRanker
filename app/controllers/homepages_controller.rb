class HomepagesController < ApplicationController
  def index
    @spotlight = Work.spotlight
    @top_ten_movies = Work.top_ten_movies
    @top_ten_books = Work.top_ten_books
    @top_ten_albums = Work.top_ten_albums
  end
end
