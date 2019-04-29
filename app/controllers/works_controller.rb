class WorksController < ApplicationController
  def index
    @albums = Work.albums
    @books = Work.books
    @movies = Work.movies
  end

  def show
    work_id = params[:id]
    @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:error] = "A problem occurred: Work could not be found"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new(title: "Default")
  end

  def create
    work = Work.new(work_params)

    is_successful = work.save

    if is_successful
      flash[:success] = "Work added successfully"
      redirect_to works_path #make work_path(work.id)
    else
      work.errors.messages.each do |field, messages|
        flash[notice] = "A problem occurred: Could not create #{work.category}"
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      flash[:error] = "A problem occurred: Work could not be found"
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    is_successful = @work.update(work_params)

    if is_successful
      flash[:success] = "Successfully updated #{@work.category} #{@work.id}"
      redirect_to work_path(@work.id)
    else
      @work = work
      render :edit, status: :bad_request
    end
  end

  def destroy
    work = Work.find_by(id: params[:id])

    if work.nil?
      flash[:error] = "A problem occurred: Work could not be found"
    else
      work.destroy
      flash[:success] = "Successfully destroyed #{work.category} #{work.id}"
    end
    redirect_to root_path
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
