class WorksController < ApplicationController
  
  def index
    @albums = Work.where(category: "album")
    @movies = Work.where(category: "movie")
    @books = Work.where(category: "book")
    @spotlight = Work.all.sample(10)

  end

  def show
    @work = Work.find_by(id: params[:id])
    if @work.nil? 
      flash[:error] = "Unknown works"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    @work.save 
    redirect_to work_path(@work.id)
  end

  def edit
    @work = Work.find(params[:id])
  end

  def update
    @work = Work.find(params[:id])
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  # def upvote
  #   Work.upvote(@work)
  #   redirect_to work_path(@work.id)
  # end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      # raise
      flash[:error] = "That media does not exist"
    else
      # raise
      @work.destroy
      flash[:success] = "#{@work.id} deleted"
      redirect_to works_path
    end
  
    
  end

private 

  def work_params
    return params.require(:work).permit(:category, :title, :publication_year, :description, :creator)
  end

end