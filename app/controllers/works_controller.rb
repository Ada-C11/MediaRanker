class WorksController < ApplicationController
  def index
    # update to be ordered by number of votes...when those are linked.
    @books = Work.where(category: "book")
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
  end

  def show
    @work = Work.find_by(id: params[:id])

    if !@work
      redirect_to root_path if @work.nil?
      flash[:failure] = "Sorry, we couldn't find the media page you were looking for."
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    # could move this to the application controller as a method, and use it for all controllers!
    if @work.save
      flash[:success] = "Successfully created #{@work.title} #{@work.category}!"
      redirect_to work_path(@work.id)
    else
      flash.now[:failure] = "A problem occurred: Could not create #{@work.category}"
      @work.errors.messages.each do |field, messages|
        # storing these messages in the flash.now hash so we can loop through in the view
        flash.now[field] = messages
      end
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

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      redirect_to root_path
    else
      work.destroy
      redirect_to works_path
    end
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
