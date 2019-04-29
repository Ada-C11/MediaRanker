class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Work.get_media_catagories
  end

  def show
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
    unless @work
      redirect_to works_path
      flash.now[:status] = :warning
      flash.now[:message] = "Could not find work #{params[:id]}"
    end
  end

  def update
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
      @errors = @work.errors
      render :edit, status: :bad_request
    end
  end

  def destroy
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
