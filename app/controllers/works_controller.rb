class WorksController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.sort_media("album")
    @movies = Work.sort_media("movie")
    @books = Work.sort_media("book")
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save

    if successful
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to works_path
    else
      flash.now[:error] = "A problem occurred: Could not create work."
      render :new, status: :bad_request
    end
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end

  def edit
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
    end
  end

  def update
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    work_id = params[:id]
    work = Work.find_by(id: work_id)

    unless work
      head :not_found
      return
    end

    work.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted book #{work.category} #{work.id}"
    redirect_to works_path
  end

  def upvote
    @current_user = User.find_by(id: session[:user_id])
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @current_user.nil?
      flash[:error] = "You must be logged in to see this page"
      redirect_to login_path
    elsif Vote.exists?(user_id: @current_user.id, work_id: work_id)
      flash[:error] = "You already upvoted this title."
      redirect_to work_path(@work)
    else
      @vote = Vote.create(
        user_id: @current_user.id,
        work_id: @work.id,
      )
      flash[:success] = "Successfully upvoted #{@work.title}"
      redirect_to user_path(@current_user.id)
    end  
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
