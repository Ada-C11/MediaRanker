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
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to work_path(@work.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    redirect_to root_path if @work.nil?
  end

  def update
    work = Work.find_by(id: params[:id])

    is_successful = work.update(work_params)

    if is_successful
      redirect_to work_path(work.id)
    else
      @work = work
      render :edit, status: :bad_request
    end
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
