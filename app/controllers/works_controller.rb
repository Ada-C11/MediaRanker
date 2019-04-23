class WorksController < ApplicationController
  def index
    @works = Work.all.order(:title)
  end

  def show
    # TODO: why will this not work with find_by
    @work = Work.find_by(id: params[:id])
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

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])
    if work.update(work_params)
      redirect_to work_path(work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      head :not_found
    else
      work.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
