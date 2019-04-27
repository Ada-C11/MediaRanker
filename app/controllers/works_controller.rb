class WorksController < ApplicationController
  before_action :find_indv_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    new_work = Work.new(work_params)

    is_successful = new_work.save

    if is_successful
      flash[:success] = "Successfully created #{params[:category]} #{params[:id]}"

      # NEED TO MAKE HOME PAGE FOR ROOT PATH!!!
      redirect_to root_path
    else
      new_work.errors.messages.each do |field, message|
        flash.now[field] = message
      end
      render :new, status: :bad_request
    end
  end

  def show
    # The live app gives a 404. I wanted to give a helpful flash message and redirect instead for a better work experience.

    # find_indv_work
    if !@work
      flash[:error] = "work not found"
      redirect_to works_path
    end
  end

  def edit
    head :not_found if !@work
  end

  def update
    is_successful = @work.update(work_params)

    if @work && is_successful
      flash[:success] = "Successfully updated #{params[:category]} #{params[:id]}"

      # NEED TO MAKE HOME PAGE FOR ROOT PATH!!!
      redirect_to root_path
    else
      @work.errors.messages.each do |field, message|
        flash.now[field] = message
      end
      render :new, status: :bad_request
    end
  end

  def destroy
    # find_indv_work
    if !@work
      flash[:error] = "That item does not exist"
      redirect_to works_path
    else
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
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
