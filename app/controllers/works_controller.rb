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
      flash[:error] = "Work not found!"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new

    user_id = session[:user_id]

    if user_id.nil?
      flash[:error] = "Must be logged in to view page."
    else
      head :success
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def update
    if @work.nil?
      redirect_to works_path
    else
      successful = @work.update(work_params)
    end

    redirect_to work_path(@work.id) if successful
  end

  def create
    @work = Work.new(work_params)
    successful = @work.save

    if successful
      flash[:status] = :success
      redirect_to works_path
    else
      render :new, status: :bad_request
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

private

def work_params
  params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
end
