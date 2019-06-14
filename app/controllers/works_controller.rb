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
      flash[:success] = "Work added"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error:  work not added"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
    end
  end

  def edit
    @work - Work.find_by(id: params[:id].to_i)
  end

  def update
    @work - Work.find_by(id: params[:id].to_i)
    if @work.update(work_params)
      flash[:success] = "Changes saved"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error: changes not saved"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def destroy
    unless @work.nil?
      work = Work.find_by(id: params[:id].to_i)
      deleted_work = @work.destroy
      flash[:success] = "#{deleted_work.title} deleted"

      redirect_to root_path
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
