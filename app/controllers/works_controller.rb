class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Work.categories
  end

  def show
    if !@work
      flash[:error] = "No work with that ID found."
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
    @categories = Work.categories
  end

  def create
    work = Work.new(work_params)

    work.save

    redirect_to works_path
  end

  def edit
    if !@work
      flash[:error] = "No work with that ID found."
      redirect_to works_path
    end

    @categories = Work.categories
  end

  def update
    if !@work
      flash[:error] = "No work with that ID found."
      redirect_to works_path
    end

    @work.update(work_params)

    redirect_to work_path(@work.id)
  end

  def destroy
    if !@work
      flash[:error] = "No work with that ID found."
      redirect_to works_path
    end

    @work.destroy

    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :pub_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
