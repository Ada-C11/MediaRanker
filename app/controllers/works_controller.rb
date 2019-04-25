class WorksController < ApplicationController
  # t.string :category
  # t.string :title
  # t.string :creator
  # t.date :publication_year
  # t.string :description

  def index
    @works_by_category = Work.all.group_by{ |work| work.category }
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    if @work.save
      redirect_to @work, notice: "Work was successfully created."
    else
      render :new
    end
  end

  def edit
      @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to @work, notice: "Work was successfully updated."
    else
      render :new
    end
  end

  def show
      @work = Work.find(params[:id])
  end

  def destroy
    work_id = params[:id]

    work = Work.find_by(id: work_id)

    unless work
      head :not_found
      return
    end

    work.destroy

    redirect_to works_path
  end

  def upvote
  end

end
