class WorksController < ApplicationController
  before_action :find_work, only: %i[show edit update upvote]
  def index
    # @works = Work.all
    # @categories = Category.all.includes(:works)
    @categories = Category.all
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully created #{@work.category.name} #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :warning
      error_message = "A problem occurred: Could not create #{@work.category.name}"
      @work.errors.messages.each do |column, problem_list|
        problem_list.each do |problem|
          error_message += "#{column}: #{problem}"
        end
      end
      flash.now[:message] = error_message
      render :new, status: :bad_request
    end
  end

  def update
    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated #{@work.category.name} #{@work.id}"
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
      flash.now
    end
  end

  def destroy
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work
      @work.destroy
      flash[:status] = :success
      flash[:message] = "Successfully destroyed #{@work.category.name} #{@work.id}"
      redirect_to works_path
    else
      head :not_found
    end
  end

  def upvote
    @current_user = User.find_by(id: session[:user_id])
    if !@current_user
      flash[:status] = :error
      flash[:message] = 'A problem occurred: You must log in to do that'
      redirect_to root_path
    elsif @work.votes.find_by(user_id: @current_user.id)
      flash[:status] = :error
      flash[:message] = 'A problem occurred: has already voted for this work'
      redirect_back(fallback_location: root_path)

    else
      Vote.create!(work_id: @work.id, user_id: @current_user.id)
      flash[:status] = :success
      flash[:message] = 'Successfully Upvoted!'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def work_params
    params.require(:work).permit(:title, :creator, :publication_year, :description, :category_id)
  end

  def find_work
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    head :not_found unless @work
  end
end
