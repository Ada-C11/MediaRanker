class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def homepage
    @works = Work.all 
    @ranked_works = @works.order(:id)
  end

  def show
    if !@work
      flash[:error] = "Unknown work"

      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)

    is_successful = work.save

    if is_successful
      flash[:success] = "Successfully created #{work.category} #{work.id}"
      redirect_to work_path(work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{work.category}"
      work.errors.messages.each do |field, messages|
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
      flash.now[:error] = "A problem occurred: Could not create album"
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
      @work.destroy
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
    end

    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :created_by, :published, :description)
  end
end
