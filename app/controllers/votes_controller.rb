class VotesController < ApplicationController
  def index
    @votes = Vote.all
  end

  def show
    @vote = Vote.find_by(id: params[:id])

    if @vote.nil?
      redirect_to votes_path
    end
  end

  def new
    @vote = Vote.new
  end

  def create
    vote = Vote.new(vote_params)

    is_successful = vote.save

    if is_successful
      redirect_to vote_path(vote.id)
    else
      render :new, status: :bad_request
    end
  end

  def edit
    @vote = Vote.find_by(id: params[:id])

    if @vote.nil?
      redirect_to votes_path
    end
  end

  def update
    vote = Vote.find_by(id: params[:id])

    if vote.nil?
      redirect_to votes_path
    else
      is_successful = Vote.update(vote_params)
    end

    if is_successful
      redirect_to vote_path(vote.id)
    else
      @vote = vote
      render :edit, status: :bad_request
    end
  end

  def destroy
    vote = vote.find_by(id: params[:id])

    if vote.nil?
      head :not_found
    else
      vote.trips.each do |trip|
        trip.destroy
      end
      vote.destroy
      redirect_to votes_path
    end
  end

  private

  #CAN YOU DO STRONG PARAMS THERES????
  def vote_params
    return params.require(:vote).permit(:votename)
  end
end
