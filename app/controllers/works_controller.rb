class WorksController < ApplicationController
  def index
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to root_path #update to details page once created!
    else
      flash.now[:status] = :error
      flash.now[:message] = "A problem occurred: could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
