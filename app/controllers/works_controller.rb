class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    work_to_create = Work.new(work_params)

    if work_to_create.save
      flash[:success] = "Successfully created #{work_to_create.category} #{work_to_create.id}"
      redirect_to work_path(work_to_create.id)
    else
      work_to_create.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new
    end
  end

  def edit
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.update(work_params)
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
    work_to_destroy = Work.find_by(id: params[:id])

    if work_to_destroy.nil?
      flash[:error] = "That work does not exist"
      redirect_to works_path
    else
      work_to_destroy.destroy
      flash[:success] = "Successfully destroyed #{work_to_destroy.category} #{work_to_destroy.id}"
      redirect_to root_path
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :category, :publication_year)
  end
end
