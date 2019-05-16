class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @albums = Work.index_media("album")
    @books = Work.index_media("book")
    @movies = Work.index_media("movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      flash[:status] = :success
      flash[:message] = "Successfuly created #{@work.category}  #{Work.where(category: @work.category).count}"
      redirect_to works_path
    else
      flash.now[:status] = :error
      flash.now[:message] = "A problem occurred:  Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def show
    unless @work
      head :not_found
    end
  end

  def edit
    unless @work
      head :not_found
    end
  end

  def update
    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category} NUMBER HERE"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save #{@work.category} NUMBER HERE"
      render :edit, status: :bad_request
    end
  end

  def destroy
    unless @work
      head :not_found
      return
    end

    successful = @work.destroy
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully destroyed work #{@work.id}."
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by_id(params[:id])
  end
end
