class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.sort_by { |work| -work.votes.count }
  end

  def show
    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, message|
        flash.now[field] = message
      end
      render :new, status: :bad_request
    end
  end

  def edit
    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    else
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      redirect_to root_path
    end
  end

  def upvote
    current_work = Work.find_by(id: params[:id])

    if session[:user_id]
      vote = Vote.new(user_id: session[:user_id], work_id: current_work.id)

      if vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "user: has already voted for this work"
      end
    else
      flash[:error] = "You must log in to do that"
    end

    redirect_back fallback_location: works_url
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :category, :publication_year)
  end
end
