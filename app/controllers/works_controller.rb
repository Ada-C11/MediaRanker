class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def new
    @work = Work.new(category: "Category", title: "Title", creator: "Creator", publication_year: "Publication Year", description: "Description")
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if !work
      head :not_found
    else
      work.destroy
      redirect_to works_path
    end
  end
end
