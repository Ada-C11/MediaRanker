class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      redirect_to works_path
    else
      render :new, status :bad_request
    end
  end

  def show 
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end

    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit, status :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    work.destroy

    redirect_to root_path
  end

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end
