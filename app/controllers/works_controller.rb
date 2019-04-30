class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @movies = Work.category_list("movie")
    @books = Work.category_list("book")
    @albums = Work.category_list("album")
  end

  def show
    if @work.nil?
      render :not_found, status: :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:warning] = "A problem occurred: Could not create #{@work.category}"
      render :new
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:warning] = "Could not update #{@work.category}"
      render :edit
    end
  end

  def destroy
    unless @work.nil?
    @work.votes.destroy_all
    end

    @deleted_work = @work.destroy
    flash[:success] = "Successfully destroyed #{@deleted_work.category} #{@deleted_work.id}"
    redirect_to root_path
  end

  def upvote
    if @super_user.nil?
      flash[:warning] = "Please log in so your vote can be counted."
      redirect_to login_path
    else
      if @super_user.has_voted?(@work.id)
        flash[:warning] = "Sorry, you can't vote twice on the same work."
        redirect_back fallback_location: works_path
      else
        Vote.create(user_id: @super_user.id, work_id: @work.id)
        flash[:success] = "Your vote has been counted!"
        redirect_back fallback_location: works_path
      end
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end