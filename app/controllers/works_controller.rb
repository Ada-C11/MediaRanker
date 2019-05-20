class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    # @works = Work.all
    @albums = Work.sort_work("album")
    @movies = Work.sort_work("movie")
    @books = Work.sort_work("book")
  end

  def show
    # @work = Work.find_by(id: params[:id])
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
      flash[:success] = "#{work.title} added successfully"
      redirect_to work_path(work.id)
    else
      work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])
    if @work.nil?
      redirect_to works_path
    end
  end

  def update
    # work = Work.find_by(id: params[:id])

    updated_successfully = @work.update(work_params)

    if updated_successfully
      flash[:success] = "#{@work.title} updated successfully"
      redirect_to work_path(@work.id)
    else
      # @work = work
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    # work_to_destroy = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "That work does not exist"
    else
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
    end

    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :publication_year, :category, vote_id: [])
  end

  # optional
  # def set_flash_status(message, status)
  #   flash[status] = message
  # end
end
