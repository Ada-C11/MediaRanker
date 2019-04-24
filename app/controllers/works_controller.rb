class WorksController < ApplicationController
  def index
    if params[:work_id]
      @works = Work.where(work: Work.find_by(id: params[:work_id]))
    else
      @works = Work.all.order(:title)
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:error] = "Unknown work"

      redirect_to works_path
    end
  end

  def new
    @work = Work.new(title: "Default Title", category: "album")
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "work added successfully"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    work = Work.find_by(id: params[:id])

    is_successful = work.update(work_params)

    if is_successful
      flash[:success] = "work updated successfully"
      redirect_to work_path(work.id)
    else
      @work = work
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    else
      work.destroy
      flash[:success] = "#{work.title} deleted"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :category, :publication_year)
  end
end
