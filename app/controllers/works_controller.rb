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
      
      redirect_to work_path(@work.id)
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    
    unless @work
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    
    if @work.update(book_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated work #{@work.id}"
      
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work #{@work.id}"
      
      render :edit, status: :bad_request
    end
  end

  def delete
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    
    if @work.destroy
      flash[:status] = :success
      flash[:message] = "#{@work.name} has been deleted."
      
      redirect_to works_path
    else
      flash.now[:status] = :error
      flash.now[:message] = "Unable to delete #{@work.name}"

      render :edit
    end
  end
  
  private
  
  def work_params
    return params.require(:work).permit(:category, :title, :author, :publication_year, :description)
  end
end
