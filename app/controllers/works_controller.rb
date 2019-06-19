class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]

  def index
    @works = Work.all
  end

  def show
    if @work.nil?
      flash[:warning] = "Work not found."
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      flash[:success] = "Work added"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error:  work not added"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Changes saved"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Error: changes not saved"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit
    end
  end

  def destroy
    unless @work.nil?
      deleted_work = @work.destroy
      flash[:success] = "#{deleted_work.title} deleted"
      redirect_to root_path
    end
  end

  def upvote
    user = User.find_by(id: session[:user_id])

    if user.nil?
      flash[:warning] = "A problem occurred: you must log in to vote"
      redirect_back(fallback_location: root_path)
    elsif user.eligible_to_vote?(@work)
      vote = Vote.new(work: @work, user: user, date: Date.today)

      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to root_path
      else
        flash.now[:warning] = "Error: could not process vote"
        redirect_back(fallback_location: root_path)
      end
    else
      flash[:warning] = "A problem occurred: you've already voted on this work"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  def find_work
    @work = Work.find_by(id: params[:id].to_i)

    if @work.nil?
      flash.now[:warning] = "Cannot find the work"
    end
  end
end
