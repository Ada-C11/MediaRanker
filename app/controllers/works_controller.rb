class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy, :upvote]

  def index
    @works = Work.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:status] = :error
      flash.now[:message] = "A problem occurred: could not create #{@work.category}"
      render :new, status: :bad_request
    end
  end

  def show; end

  def edit; end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated work #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work #{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted work #{@work.id}"
    redirect_to works_path
  end

  def upvote
    if session[:user_id]
      current_user = User.find(session[:user_id])

      if @work.users.include?(current_user)
        flash[:status] = :error
        flash[:message] = "Cannot vote more than once"
      else
        @work.users.push(current_user)
        flash[:status] = :success
        flash[:message] = "Successfully upvoted"
      end
    else
      flash[:status] = :error
      flash[:message] = "Must be logged in to vote"
    end

    redirect_to work_path(@work)
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end
  end
end
