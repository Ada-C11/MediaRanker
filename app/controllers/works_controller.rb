class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  before_action :redirect_if_not_found, only: [:show, :edit, :update, :destroy]

  def index
    @books = Work.where(category: "book").order("votes_count DESC")
    @movies = Work.where(category: "movie").order("votes_count DESC")
    @albums = Work.where(category: "album").order("votes_count DESC")
  end

  def new
    @work = Work.new
  end

  def top_works
    @featured = Work.top_work

    @books = Work.top_ten("book")
    @movies = Work.top_ten("movie")
    @albums = Work.top_ten("album")
  end

  def create
    @work = Work.new(work_params)
    @work.votes_count = 0
    success = @work.save

    if success
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :warning
      flash.now[:message] = "Could not update #{@work.category} #{@work.id}"
      render :edit
    end
  end

  def destroy
    @work.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted #{@work.category} #{@work.id}"

    redirect_to works_path
  end

  def show
    @votes = Vote.where(work_id: @work.id)
  end

  # def edit ; end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :category, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def redirect_if_not_found
    unless @work
      flash[:status] = :warning
      flash[:message] = "No work found for ID #{params[:id]}"
      redirect_to root_path
    end
  end
end
