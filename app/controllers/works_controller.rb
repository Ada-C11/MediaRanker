class WorksController < ApplicationController
  def index
    # update to be ordered by number of votes...when those are linked.
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])

    redirect_to root_path if @work.nil?
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def delete
  end

  private

  def work_params
    return params.require(:work).permit(:category,
                                        :title,
                                        :creator,
                                        :publication_year,
                                        :description)
  end
end
