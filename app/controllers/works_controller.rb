class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]
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
      flash[:message] = "Work: #{@work.title}, ID: #{@work.id} successfully created"
      redirect_to works_path
    else
      flash.now[:status] = :error
      flash.now[:message] = "There were some errors with your "
      render :new, status: :bad_request
    end
  end

  def show 
    # @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def edit
    # @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
    end
  end

  def update
    # @work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end

    if @work.update(work_params)
      redirect_to work_path(@work)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    # work = Work.find_by(id: params[:id])

    unless @work
      head :not_found
      return
    end

    @work.destroy

    redirect_to works_path
  end

  def work_params
    params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end

  private 

  def find_work
    @work = Work.find_by(id: params[:id])
  end

end
