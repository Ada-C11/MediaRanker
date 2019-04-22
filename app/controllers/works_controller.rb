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
    @work.save
  end

  def work_params
    return params.require(:work).permit(:type, :title, :created_by, :published)
  end
end
