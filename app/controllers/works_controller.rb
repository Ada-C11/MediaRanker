class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)
    is_successful = work.save

    if is_successful
      redirect_to work_path(work.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category)
  end
end
