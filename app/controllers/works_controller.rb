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
      flash[:warning] = "A problem occurred: Media not found"
      redirect_to root_path
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
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if !@work
      flash[:warning] = "A problem occurred: Media not found."
      redirect_to root_path
    end
  end

  def update
    work = Work.find_by(id: params[:id])

    is_successful = work.update(work_params)

    if is_successful
      flash[:success] = "Successfully updated #{work.title} #{work.category}!"
      redirect_to work_path(work.id)
    else
      @work = work
      flash.now[:warning] = "A problem occurred: Could not update #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if !work
      flash[:failure] = "Failed to destroy media"
      redirect_to root_path
    else
      work.votes.each { |vote| vote.destroy }
      work.destroy
      flash[:success] = "Succesfully destroyed #{work.category} #{work.id}"
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
