class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      redirect_to works_path
      flash[:error] = "Unknown work"
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)
    is_successful = work.save

    if is_successful
      flash[:success] = "#{work.title} added successfully :)"
      redirect_to work_path(work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
        render :new, status: :bad_request
      end
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    work = Work.find_by(id: params[:id])

    updated_successfully = work.update(work_params)

    if updated_successfully
      flash[:success] = "#{work.title} updated successfully"
      redirect_to work_path(work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    work_to_destroy = Work.find_by(id: params[:id])

    if work_to_destroy.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    else
      work_to_destroy.destroy
      flash[:success] = "#{work_to_destroy.title} deleted"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category)
  end
end
