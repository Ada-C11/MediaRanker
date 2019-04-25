class WorksController < ApplicationController
  def index
    @books = Work.books
    @albums = Work.albums
  end

  def top
    @featured_work = Work.spotlight
    @top_albums = Work.top_ten_albums
    @top_books = Work.top_ten_books
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path
    else
      render :new, status: :bad_request
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year)
  end
end
