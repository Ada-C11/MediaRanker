class WorksController < ApplicationController
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      # Set flash status to success
      flash[:status] = :success
      # Set flash message
      flash[:message] = "Successfuly created #{@work.category}  #{Work.where(category: @work.category).count}"
      # Don't use NOW since we redirect
      redirect_to works_path
    else
      # Set flash.now status to error
      flash.now[:status] = :error
      # Set flash.now message
      flash.now[:message] = "A problem occurred:  Could not create #{@work.category}"
      # Use NOW since we RENDER
      render :new, status: :bad_request
    end
  end

  def show
    # Grab the id of work we wanna show
    work_id = params[:id]
    # Use that id to find work object, assign it a name
    @work = Work.find_by(id: work_id)

    # If the work doesn't exist, not found!
    unless @work
      head :not_found
    end
  end

  def edit
    # What's the work id?
    work_id = params[:id]

    # What's the work?
    @work = Work.find_by(id: work_id)

    # Does this work even exist?
    # If not, what happens? head :not_found

    unless @work
      head :not_found
    end
  end

  def update
    # What work are we updating?
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    # # Does this work even exist?
    unless @work
      head :not_found
      return
    end
    # If not, what happens?  head :not_found

    # If it updates...
    # Flash status is success!
    # Flash message => Successfully updated album 322
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category} #{Work.where(category: @work.category).count}"
      redirect_to work_path(@work)
    end

    # If it fails...
    # Flash status is error!
    # Flash message => Could not save album 322
    # render :edit, status: :bad_request
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
