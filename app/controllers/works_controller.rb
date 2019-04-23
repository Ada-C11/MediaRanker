class WorksController < ApplicationController
  def index
    @work = Work.all
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    unless @work
      redirect_back(fallback_location: works_path)
      flash[:error] = "That item cannot be found or no longer exists."
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    
    @work.save
    
    unless @work
      render :new
      flash[:error] = "Item can't be created at this time."
    else
      flash[:success] = "#{@work.title} has been successfully added."
      
      redirect_to works_path
    end
  end

  def edit
  end

  def update
  end

  def delete
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :author, :publication_year, :description)
  end
end
