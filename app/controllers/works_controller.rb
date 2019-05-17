class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]
  
  def index
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end

  def show 
    if @work.nil?
      flash[:failure] = "Your search returned no results."
      redirect_to root_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "#{@work.title} was successfully created."
      redirect_to work_path(@work.id)
    else
      flash.now[:failure] = "Unable to create #{@work.category}"
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render(:new, status: :bad_request)
    end
  end

  def edit
    unless @work
      head :not_found
    end
  end

  def update
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.title}"
      redirect_to work_path(@work.id)
    else
      flash.now[:error] = "Unable to complete your update request."
      render(:edit, status: :bad_request)
    end

  end

  def destroy
    if !@work
      flash[:failure] = "Unable to delete the specified media."
      redirect_to root_path
    else
      @work.destroy
      flash[:success] = "Success! #{@work.title} is now deleted."
      redirect_to works_path
    end

  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :pub_year, :description, :votes)
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
