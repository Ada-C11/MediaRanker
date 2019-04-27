class WorksController < ApplicationController
  before_action :find_indv_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
  end

  def create
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    # find_indv_user
    if !@work
      flash[:error] = "That item does not exist"
      redirect_to works_path
    else
      work.destroy
      flash[:success] = "#{work.title} deleted"
      redirect_to works_path
    end
  end

  private

  def find_indv_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
