class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :all_works_sorted_by_votes, only: [:index, :top_media]

  def index
  end

  def top_media
    @top_works = @works
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

  def all_works_sorted_by_votes
    @works = Work.sort_by_votes
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end
end
