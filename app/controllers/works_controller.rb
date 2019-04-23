class WorksController < ApplicationController
  def index
    @works = Work.all
    books = Work.where(category: "book")
    albums = Work.where(category: "album")
    movies = Work.where(category: "movie")
    @categories = [books, albums, movies]
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end
end
