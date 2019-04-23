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
  end

  def update
  end

  def destroy
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
