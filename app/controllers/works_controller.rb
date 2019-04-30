# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :find_individual_work, only: %i[show edit update destroy]

  def index
    @works = Work.all
  end

  def show
    redirect_to works_path if @work.nil?
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    is_successful = @work.save

    if is_successful
      redirect_to work_path(@work.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    redirect_to works_path if @work.nil?
  end

  def update
    if @work.nil?
      redirect_to works_path
    else
      is_successful = @work.update(work_params)
    end

    redirect_to work_path(@work.id) if is_successful
  end

  def destroy
    if @work.nil?
      flash[:error] = 'That work does not exist'
    else
      @work.destroy
      flash[:success] = "#{@work.title} deleted"
    end
    redirect_to root_path
  end

  private

  def find_individual_work
    @work = Work.find_by(id: params[:id])
  end

  def work_params
    params.require(:work).permit(:media, :title, :created_by, :published, :description, :votes)
  end
end
