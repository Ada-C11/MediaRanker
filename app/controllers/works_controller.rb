class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new work_params

    if @work.save
      redirect_to work_path(@work.id), { :flash => { :success => "Successfully created work!" } }
    else
      render :new, status: :bad_request, :flash.now => { :error => "Failed to create work" }
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
      redirect_to root_path, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work
      if @work.update work_params
        redirect_to work_path(@work.id), { :flash => { :success => "Successfully updated work!" } }
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
        redirect_to root_path, { :flash => { :success => "Successfully deleted work!" } }
      else
        redirect_to root_path, :flash => { :error => "Failed to delete work" }
      end
    else
      redirect_to root_path, status: 302, :flash => { :error => "Could not find work with id: #{params[:id]}" }
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
