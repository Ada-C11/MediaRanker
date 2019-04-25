# frozen_string_literal: true

class WorksController < ApplicationController
  before_action :find_work, only: %i[show edit destroy update]

  def index
    @works = Work.all.sort_by(&:id)
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)

    successful = @work.save
    if successful
      flash[:status] = :success
      flash[:message] = "successfully saved a work with ID #{@work.id}"
      redirect_to works_path
    else
      flash.now[:status] = :error
      flash.now[:message] = 'Could not save work'
      render :new, status: :bad_request
    end
  end

  def show
    # work_id = params[:id]

    # @work = Work.find_by(id: work_id)

    # head :not_found unless @work
  end

  def edit
    # work_id = params[:id]

    # @work = Work.find_by(id: work_id)

    # head :not_found unless @work
  end

  def update
    # work_id = params[:id]

    # @work = Work.find_by(id: work_id)

    # head :not_found unless @work

    if @work.update(work_params)
      flash[:status] = :success
      flash[:message] = "Successfully updated work #{@work.id}"
      redirect_to work_path(@work)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not save work #{@work.id}"
      render :edit, status: :bad_request
    end
  end

  def destroy
    # work_id = params[:id]

    # @work = Work.find_by(id: work_id)

    # head :not_found unless @work

    @work.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted work #{@work.id}"
    redirect_to works_path
  end

  def upvote
    @work = Work.find(params[:id])
    user_id = session[:user_id]
    @user = User.find(user_id )

    # @work.votes.create(work_id: @work.id, user_id: @work.users)

    if @work.number_of_votes.nil?
      @work.update(number_of_votes: 1)
    else
      @work.update(number_of_votes: @work.number_of_votes + 1)
    end

    if @user.number_of_votes.nil?
      @user.update(number_of_votes: 1)
    else
      @user.update(number_of_votes: @user.number_of_votes + 1)
    end

    puts @work.errors.messages

    redirect_to(works_path)
  end
end

private

def work_params
  params.require(:work).permit(
    :category,
    :title,
    :creator,
    :publication_year,
    :description,
    :votes
  )
end

# Method so i dont repeat this
def find_work
  @work = Work.find_by_id(params[:id])
  head :not_found unless @work
end
