class WorksController < ApplicationController
  
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    success = @work.save
    if success
      redirect_to works_path
    else
      render :new
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if !@work
      head :not_found
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work
      success = @work.update(work_params)
      if success
        redirect_to work_path(params[:id])
      else
        render :edit
      end
    else
      head :not_found
    end
  end

  def destroy
    work_id = params[:id]
    work = Work.find_by(id: work_id)

    if work
      work.destroy
      redirect_to works_path
    else
      head :not_found
    end
  end

private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

end

