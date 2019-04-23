class HomepagesController < ApplicationController
  def index
    @featured = Work.all.sample
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end
end
