class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    @work = Work.find_by(id: params[:id])
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
      @work.errors.messages.each do |label, message|
        flash.now[label.to_sym] = message
      end
      render :new, status: :bad_request
    end
  end

  def update
    @work = Work.find_by(id: params[:work][:id])
    if @work.update(work_params)
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @work.errors.messages.each do |label, message|
        flash.now[label.to_sym] = message
      end
      render :edit, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])
    unless @work
      head :not_found
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work
      flash[:success] = "Successfully destroyed #{@work.category} #{@work.id}"
      @work.destroy
      redirect_to root_path
    else
      head :not_found
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :category, :creator, :publication_year, :description)
  end
end
