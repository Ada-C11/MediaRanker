class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new
    end
  end

  def edit
    if @work.edit(work_params)
      success_redirect("Changes made successfully!", work_path(@work.id))
    else
      error_render(@work, :edit)
    end
  end

  def destroy
    unless @work.nil?
      deleted_work = @work.destroy
      success_redirect("Deleted!", root_path)
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
