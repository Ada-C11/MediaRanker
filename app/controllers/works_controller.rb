class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      flash[:status] = :success
      flash[:message] = "Work added successfully"
      redirect_to work_path(@work.id)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Work could not be added. Try again."
      render :new, status: :bad_request
    end
  end

  # def show ; end
  # def edit ; end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save #{@work.category}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted #{@work.category} #{@work.title}"
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end
  end
end
