class HomepagesController < ApplicationController
  def index
    @media_spotlight = Work.media_spotlight

    @top_movies = Work.top_media("movie")
    @top_books = Work.top_media("book")
    @top_albums = Work.top_media("album")
  end
end
