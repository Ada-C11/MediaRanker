class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :vote]

  def index
    @works = Work.all
    @categories = ['album', 'book', 'movie']
  end

  def edit
    unless @work
      redirect_to works_path
      flash.now[:status] = :warning
      flash.now[:message] = "Could not edit for Work ID \##{params[:id]}"
    end
  end

  def show 
    unless @work 
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    puts "Creating new media..."

    @work = Work.new(work_params)
    
    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully saved media with ID #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save media"
      render :new, status: :bad_request
    end
  end

  def update
    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated Work \##{params[:id]}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :warning
      flash.now[:message] = "A problem occurred: Could not update Work \##{params[:id]}"
      render :edit, status: :bad_request 
    end
  end

  def destroy 
    unless @work
      head :not_found 
      return 
    end

    @work.destroy
    flash[:success] = "Successfully destroyed work \"#{@work.title}\""
    redirect_to works_path
  end

  def vote
    if session[:user_id]
      voter_id = session[:user_id]
      vote = Vote.new(user_id: voter_id, work_id: @work.id)
      successful = vote.save

      if successful 
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "A problem occurred: Could not upvote"
      end
    else
      flash[:error] = "A problem occured: You must log in to do that"
    end

    redirect_to works_path
  end

  private
  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :vote_id, :vote_count)
  end

  def find_work 
    @work = Work.find_by(id: params[:id])
  end
end
