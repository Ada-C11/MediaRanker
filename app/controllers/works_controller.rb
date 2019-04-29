class WorksController < ApplicationController
  def index
    @works = Works.all
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:failure] = "No related media found."
      redirect_to root_path
    end
  end

  def new
    @work = Works.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
