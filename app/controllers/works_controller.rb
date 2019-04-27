class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully created media #{@work.id}"
      redirect_to works_path
    else
      flash[:status] = :error
      flash[:message] = "Could not find media with that id: #{params[:id]}"
      render :new
    end
  end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated media #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work #{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    work_id = params[:id]
    work = Work.find_by(id: work_id)
    unless work
      head :not_found
      return
    end
    work.destroy
    flash[:status] = :success
    flash[:message] = "Successfully deleted work #{work.id}"
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
    unless @work
      flash.now[:status] = :error
      flash.now[:message] = "Could not find media with that id: #{params[:id]}"
      redirect_to works_path
      return
    end
  end
end
