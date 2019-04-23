class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update]

  def index
    @movies = Work.category_list("movie")
    @books = Work.category_list("book")
    @albums = Work.category_list("album")
  end

  def show
    if @work.nil?
      render :notfound, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to works_path
    else
      render :new
    end
  end

  def edit

  end

  def update
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit
    end
  end

  def destroy
    work = Work.find_by(id: params[:id].to_i)
    @deleted_work = work.destroy

    redirect_to works_path
  end

  def upvote
    if @current_user.nil?
      flash[:warning] = "A problem occurred: You must log in to vote"
    else
      work = Work.find_by(id: params[:id].to_i)

      if @current_user.has_voted?(work.id)
        flash[:warning] = "A problem occured: Could not upvote. User has already voted for this work"
      else
        Vote.create(user_id: @current_user.id, work_id: work.id)
        flash[:success] = "Successfully upvoted!"
      end
    end
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)
  end
end