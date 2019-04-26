class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.top_ten("album")
    @books = Work.top_ten("book")
    @movies = Work.top_ten("movies")
    @spotlight = Work.spotlight
  end
end
