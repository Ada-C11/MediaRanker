class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params

    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new, status: :bad_request
    end
  end

  def show
    @work = Work.find(params[:id])

    unless @work
      head :not_found
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
