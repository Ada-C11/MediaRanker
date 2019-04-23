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
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    work = Work.find_by(id: params[:id])

    updated_successfully = work.update(work_params)

    if updated_successfully
      redirect_to work_path(work.id)
    else
      redirect_to works_path
    end
  end

  def destroy
    work_to_destroy = Work.find_by(id: params[:id])

    if work_to_destroy.nil?
      head :not_found
    else
      work_to_destroy.destroy
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category)
  end
end
