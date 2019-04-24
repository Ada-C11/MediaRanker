class WorksController < ApplicationController
  def index
    @works = Work.all
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: "Work was successfully created."
    else
      render :new
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end

  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
