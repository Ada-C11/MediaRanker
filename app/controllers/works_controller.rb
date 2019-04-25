class WorksController < ApplicationController
  before_action :find_individual_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.order(:title)
  end

  def show
    
    if @work.nil?
      flash[:error] = "unknown media"
      redirect_to works_path
    end
    
  end

  private

  def find_individual_work
    @work = Work.find_by_id(params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
