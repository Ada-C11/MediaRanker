class WorksController < ApplicationController
  before_action :find_individual_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all.order(:title)
  end

  def show
    if @work.nil?
      flash[:error] = "unknown media"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "media added successfully"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    is_successful = @work.update(work_params)

    if is_successful
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
    else
      if !@work.vote_ids.empty?
        vote = Vote.find_by(work_id: @work.id)
        vote.destroy
      end
      @work.destroy
      flash[:success] = "#{@work.title} was deleted"
    end
    redirect_to works_path
  end

  private

  def find_individual_work
    @work = Work.find_by_id(params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description, vote_ids: [])
  end
end
