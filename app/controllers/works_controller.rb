class WorksController < ApplicationController
  before_action :find_work, except: [:index, :new, :create]

  def index
    if params[:creator_id]
      @works = Work.where(creator: Author.find_by(id: params[:creator_id]))
    else
      @works = Work.all.order(:title)
    end
  end

  def new
    @work = Work.new
  end

  def create
    work = Work.new(work_params)

    if work.save
      flash[:success] = "Work added successfully"
      redirect_to work_path(work.id)
    else
      work.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end

      render :new, status: :bad_request
    end
  end

  def show
    if @work.nil?
      flash[:error] = "Unknown work"

      redirect_to works_path
    end
  end

  def update
  end

  def edit
  end

  def delete
    if @work.nil?
      flash[:error] = "That work does not exist"
    else
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
    end

    redirect_to works_path
  end

  private

  def find_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end
