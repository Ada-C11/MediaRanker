class WorksController < ApplicationController
  def index
    all_works = Work.all
    # store all works into @works
    # for each work, assign work.vote_count into vote column
    # order @works by vote count

    all_works.each do |work|
      work.vote_count = work.vote_counter
      work.save
    end
    @works = all_works.order(:vote_count).reverse
    # raise
  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      flash[:error] = "Unknown work!"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Work added successfully!"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, message|
        flash.now[field] = message
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])
    if @work.update(work_params)
      flash[:success] = "Work updated successfully!"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])
    if work.nil?
      flash[:error] = "Work already does not exist."
    else
      work.destroy
    end
    redirect_to works_path
  end

  def vote
    work = Work.find_by(id: params[:id])
    if session[:user_id]
      user_vote_id = session[:user_id]
      vote = Vote.new(user_id: user_vote_id, work_id: work.id)
      is_successful = vote.save
      raise
      if is_successful
        # raise
        flash[:success] = "Work updated successfully!"
      else
        flash[:error] = "You cannot vote on the same work!"
        # raise
      end
    else
      flash[:error] = "You must be logged in to vote!"
    end
    redirect_to works_path
  end

  private

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description, :vote_id, :vote_count)
  end
end
