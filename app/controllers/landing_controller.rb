
class LandingController < ApplicationController
  def index
    @work = Work.top_media
    @top_movies = Work.top_movies
    @top_books = Work.top_books
    @top_albums = Work.top_albums
  end
end
