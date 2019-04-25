class WorksController < ApplicationController
  def index
    @works = Work.all
    @movies = Work.where(category: "movie")
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    successful = @work.save

    if successful
      flash[:status] = :success
      flash[:message] = "successfully saved a work with title #{@work.title}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work"
      render :new, status: :bad_request
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
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end

    if @workk.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated work #{@book.title}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work #{@work.title}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    work_id = params[:id]

    work = Work.find_by(id: work_id)

    unless work
      head :not_found
      return
    end

    work.destroy

    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :creation_date, :description)
  end
end
