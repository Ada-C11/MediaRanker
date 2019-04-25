class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @books = Work.books
    @albums = Work.albums
  end

  def top
    @featured_work = Work.spotlight
    @top_albums = Work.top_ten_albums
    @top_books = Work.top_ten_books
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.delete
    flash[:status] = :success
    flash[:message] = "Successfully deleted #{@work.category} #{@work.id}"
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year)
  end

  def find_work
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    unless @work
      head :not_found
    end
  end
end
