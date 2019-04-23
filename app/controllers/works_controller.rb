class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(work_id)
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
    return params.require(:work).permit(:type, :title, :created_by, :published)
  end
end
