class WorksController < ApplicationController
  
  def index
    @works = Work.all.sort_by(&:id)
  end


  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find(work_id)
    @users = User.where(work_id: work_id.to_i)
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    redirect_to work_path if @work.nil?
  end

  def update
    begin
      work_id = params[:id]
      work = Work.find(work_id)
    rescue
      flash[:error] = "Could not find work with id: #{params['id']}"
      redirect_to work_path(work_id)
      return
    end

    if work.update(work_params)
      redirect_to works_path
    else
      render :new
    end
  end

  def destroy
    begin
      work = Work.find(params[:id])
    rescue
      flash[:error] = "Could not find work with id: #{params['id']}"
      redirect_to works_path
      return
    end
    work.destroy
    redirect_to works_path
  end

end

private

def work_params
  params.require(:work).permit(
    :category,
    :title,
    :creator,
    :publication_year,
    :description,
    :votes
  )
end
