class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def show
    work_id = params[:id].to_i
    @work = Work.find_by(id: work_id)

    if @work.nil?
      # flash[:error] = ""
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
      # flash[:error] = ""
      redirect_to works_path
    end
  end

  def update
    work_to_update = Work.find_by(id: params[:id])

    if work_to_update.nil?
      redirect_to works_path
    else
      work_to_update.update(work_params)
      flash[:success] = "Successfully updated #{work_to_update.category} #{work_to_update.id}"
      redirect_to work_path(work_to_update.id)
    end
  end

  def destroy
    work_to_destroy = Work.find_by(id: params[:id])

    if work_to_destroy.nil?
      head :not_found
      # flash[:error] = "This work does not exist"
      # redirect_to works_path
    else
      work_to_destroy.destroy
      flash[:success] = "Successfully destroyed #{work_to_destroy.category} #{work_to_destroy.id}"
      redirect_to works_path
      # should be redirected to homepage (root)
    end
  end

  private

  def work_params
    return params.require(:work).permit(:title, :description, :creator, :category, :publication_year)
  end
end
