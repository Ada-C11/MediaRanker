class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    # Move this to the Model
    # books = Work.where(category: "book")
    # albums = Work.where(category: "album")
    # movies = Work.where(category: "movie")
    # @categories = [books, albums, movies]
    @categories = Work.get_media_catagories
  end

  def show
    # @work = Work.find_by(id: params[:id])

    unless @work
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params
    @successful = @work.save
    if @successful
      redirect_to work_path(@work.id)
      flash[:status] = :success
      flash[:message] = "successfully saved a work with ID #{@work.id}"
    else
      flash.now[:status] = :warning
      flash.now[:message] = "A problem occurred: Could not create #{@work.category}"
      @errors = @work.errors
      render :new, status: :bad_request
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])
    unless @work
      redirect_to works_path
      flash.now[:status] = :warning
      flash.now[:message] = "Could not find work #{params[:id]}"
    end
  end

  def update
    # @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated work #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :warning
      flash.now[:message] = "A problem occurred: Could not update #{@work.category}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    # @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
      return
    end

    @work.destroy
    flash[:status] = :success
    flash[:message] = "Successfully deleted work #{@work.id}"
    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end
end
