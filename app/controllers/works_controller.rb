class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if !@work
      flash[:error] = "Work not found!"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new(category: "Category", title: "Title", creator: "Creator", publication_year: "Publication Year", description: "Description")
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def update
    if @work.nil?
      redirect_to works_path
    else
      successful = @work.update(category: "Category", title: "Title", creator: "Creator", publication_year: "Publication Year", description: "Description")
    end

    redirect_to work_path(@work.id) if successful
  end

  def create
    @work = Work.new(category: "Category", title: "Title", creator: "Creator", publication_year: "Publication Year", description: "Description")
    successful = @work.save

    if successful
      redirect_to work_path(@work.id)
    else
      render :new, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if !work
      head :not_found
    else
      work.destroy
      redirect_to works_path
    end
  end
end
