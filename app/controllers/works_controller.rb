class WorksController < ApplicationController
  
  def index
    @works = Work.all.order(:title)
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)

    if @work.nil?
      flash[:error] = "Unknown work"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    save_is_successful = @work.save

    if save_is_successful
      flash[:success] = "Successfully added work of art to database"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
  end

  def update
    @work = Work.find_by(id: params[:id])

    update_is_successful = @work.update(work_params)

    if update_is_successful
      flash[:success] = "Details of #{@work.title} have been updated"
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
      flash[:error] = "#{work.title} does not exist"
      redirect_to works_path
    else
      work.destroy
      flash[:success] = "#{work.title} has been deleted"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :creator, :description, :category, :publication_year)
  end
  
  def find_work_by_id
   @work = Work.find_by(id: params[:id])
  end
end
