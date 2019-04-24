# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :find_work, except: %i[index new create]

  def index
    @work = Work.ordered
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params[:work])
    if @work.save
      render :show
    else
      render :new
    end

  def show; end 

  def show; end 

  def update
    @work.update(work_params[:work])
    if @work.save
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
end

  def upvote
    Work.upvote(@work)
    redirect_to work_path(@work.id)
  end

  def destroy
    @move.destroy
    redirect_to work_path
  end

    private

  def find_work
    @work = Work.find_by(id: params[:id])

    unless @work 

  end

  def work_params
    params.permit(work: %i[title creator publication_year])
  end
end

