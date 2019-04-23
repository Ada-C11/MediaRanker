class WorksController < ApplicationController
  def index
    @works = Works.all
  end

  def show 
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:failure] = "Your search returned no results."
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
    return params.require(:work).permit(:category, :title, :creator, :pub_year, :description)
  end
end
