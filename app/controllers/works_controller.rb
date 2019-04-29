class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]

  def index
    @works = Work.all
  end

  def show
    unless @work
      head :not_found
    end
  end

  def new
    @work = Work.new()
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not create #{@work.category}"
      @work.errors.messages.each do |label, message|
        flash.now[label.to_sym] = message
      end
      render :new, status: :bad_request
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "A problem occurred: Could not update #{@work.category}"
      @work.errors.messages.each do |label, message|
        flash.now[label.to_sym] = message
      end
      render :edit, status: :bad_request
    end
  end

  def edit
    unless @work
      head :not_found
    end
  end

  def destroy
    if @work
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      @work.destroy
      redirect_to root_path
    else
      head :not_found
    end
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
