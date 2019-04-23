class WorksController < ApplicationController
  def index
    # Move this to the Model
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

  def create
    @work = Work.new work_params
    successful = @work.save
    if successful
      redirect_to work_path(@work.id)
      flash[:status] = :success
      flash[:message] = "successfully saved a work with ID #{@work.id}"
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work"
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end
end
