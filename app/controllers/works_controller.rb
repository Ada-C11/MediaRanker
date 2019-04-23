class WorksController < ApplicationController
  def index
    # @works = Work.all
    # @categories = Category.all.includes(:works)
    @categories = Category.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    successful = @work.save
    if successful
      redirect_to work_path(@work)
    else
      render :new, status: :bad_request
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    head :not_found unless @work
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    head :not_found unless @work
  end

  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    head :not_found unless @work

    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    head :not_found unless @work

    work.destroy
    redirect_to work_path
  end

  private

  def work_params
    params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end
end
