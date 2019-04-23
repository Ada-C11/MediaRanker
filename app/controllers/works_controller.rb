class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work_to_create = Work.new(work_params)

    if work_to_create.save
      redirect_to work_path(work_to_create.id)
    else
      render :new
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :category, :publication_year)
  end
end
