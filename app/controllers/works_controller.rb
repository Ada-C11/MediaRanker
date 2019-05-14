class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:failure] = "No related media found"
      redirect_to root_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "#{@work.title} was successfully created."
      redirect_to work_path(@work.id)
    else
      flash.now[:failure] = "Unable to create #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.title}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Unable to update"
      render(:edit, status: :bad_request)
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if !work
      flash[:failure] = "Unable to delete"
      redirect_to root_path
    else
      work.destroy
      flash[:success] = "Success! #{work.title} is now deleted."
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
