class WorksController < ApplicationController
  def index
  end

  def show
    @work = Work.find_by(id: params[:id])

    if !@work
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      flash[:success] = "Successfully created #{@work.category} #{@work.id}"
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

    head :not_found unless @work
  end

  def update
    work = Work.find_by(id: params[:id])

    unless work
      head :not_found
    else
      is_successful = work.update(work_params)

      if is_successful
        flash[:success] = "Successfully updated #{work.category} #{work.id}"
        redirect_to work_path(work.id)
      else
        @work = work
        @work.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :edit, status: :bad_request
      end
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      flash[:error] = "That work does not exist"
      head :not_found
    else
      work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
      redirect_to works_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
