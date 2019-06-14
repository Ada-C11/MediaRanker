class WorksController < ApplicationController
  def index
    @works = Work.all
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
    end
    render :new
  end

  def update
    @work - Work.find_by(id: params[:id].to_i)
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
      error_redirect(@work, "A problem occurred: you must log in to vote")
    elsif user.eligible_to_vote?(@work)
      vote = Vote.new(work: @work, user: user, date: Date.today)

      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      else
        error_redirect(@work, "Error: could not process vote")
      end
    else
      error_redirect(@work, "A problem occurred: you've already voted on this work")
    end
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
