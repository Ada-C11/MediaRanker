class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Work.get_media_categories
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params

    if @work.save
      redirect_to work_path(@work.id)
      flash[:status] = :success
      flash[:message] = "Work successfully created"
    else
      render :new, status: :bad_request
      flash.now[:status] = :warning
      flash.now[:message] = "Failed to create work"
    end
  end

  def show
    @work = Work.find_by(id: params[:id])

    unless @work
      redirect_to root_path, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    unless @work
      redirect_to work_path, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work
      if @work.update work_params
        redirect_to work_path(@work.id), { :flash => { :success => "Successfully updated work" } }
      else
        redirect_to :edit, :flash => { :error => "Failed to update work" }
      end
    else
      redirect_to root_path, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work
      if @work.destroy
        redirect_to root_path, { :flash => { :success => "Successfully deleted work" } }
      else
        redirect_to root_path, :flash => { :error => "Failed to delete work" }
      end
    else
      redirect_to root_path, status: 302, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :pub_yr, :description)
  end
end
