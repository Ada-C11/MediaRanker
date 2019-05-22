class HomepagesController < ApplicationController
  def index
    @works = Work.all
   @albums = Work.top("album")
   @books = Work.top("book")
   @movies = Work.top("movies")
   @spotlight = Work.spotlight
  end
end
