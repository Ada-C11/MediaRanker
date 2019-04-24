class WorksController < ApplicationController
  def index
    if params[:work_id]
      @works = Work.where(work: Work.find_by(id: params[:work_id]))
    else
      @works = Work.all.order(:title)
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:error] = "Unknown work"

      redirect_to works_path
    end
  end

  def new
  end

  def create
  end
end
