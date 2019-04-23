class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work_to_create = Work.new(work_params)

    if work_to_create.save
      redirect_to work_path(work_to_create.id)
    else
      render :new
    end
  end

  def edit
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    work_to_update = Work.find_by(id: params[:id])

    if work_to_update.nil?
      redirect_to works_path
    else
      work_to_update.update(work_params)

      redirect_to work_path(work_to_update.id)
    end
  end

  def destroy
    work_to_destroy = Work.find_by(id: params[:id])

    if work_to_destroy.nil?
      head :not_found
    else
      work_to_destroy.destroy
      redirect_to works_path
      # should be redirected to homepage (root)
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :category, :publication_year)
  end
end
