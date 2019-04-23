
class LandingController < ApplicationController
  def index
    @top_media = Work.top_media
    @top_movies = Work.top_ten("movie")
    @top_books = Work.top_ten("book")
    @top_albums = Work.top_ten("album")
  end
end
