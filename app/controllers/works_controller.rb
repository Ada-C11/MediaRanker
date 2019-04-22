class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)
    work.save
    redirect_to work_path(work.id)
  end

  def show; end

  def edit; end

  def update; end

  def delete; end

  private

  def work_params
    params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end
end
