class WorksController < ApplicationController
  def index
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end
end
