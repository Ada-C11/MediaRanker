class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.find_by_sql("SELECT COUNT(votes.work_id), works.id, title, creator, publication_year, category 
                              FROM works LEFT JOIN votes 
                              ON works.id = votes.work_id 
                              GROUP BY works.id, title, creator, publication_year, category 
                              ORDER BY COUNT(votes.work_id) desc")
  end

  def top_media
    @top_works = Work.get_top
  end

  def show
    if !@work
      flash[:error] = "Unknown media!"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)

    if work.save
      flash[:success] = "Work has been successfully created!"
      redirect_to works_path
    else
      work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    is_successful = @work.update(work_params)

    if is_successful
      flash[:success] = "Work updated successfully!"
      redirect_to work_path(@work.id)
    else
      # do i need to write tests for this?
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @work
      @work.destroy
      flash[:success] = "#{@work.title} has been deleted!"
    else
      flash[:error] = "The work does not exist!"
    end
    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end
end
