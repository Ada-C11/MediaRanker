class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new

  end

  def create

  end

  def show 

  end

  def edit

  end

  def update

  end

  def destroy

  end

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
