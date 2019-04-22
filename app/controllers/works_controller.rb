class WorksController < ApplicationController
  def index
    @works = Work.all.order(:title)
  end

  def show
    @work = Work.find_by(params[:id])
    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)
    if work.save
      redirect_to work_path(work.id)
    else
      render :new, status: :bad_request
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
