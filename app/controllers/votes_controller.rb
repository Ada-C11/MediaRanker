class VotesController < ApplicationController
  def create
    @vote = Vote.new
    work_id = params[:work_id]
    if session[:user_id]
      user_id = session[:user_id]
      @vote.user_id = user_id
      @vote.work_id = params[:work_id]
      begin
        @vote.save
        redirect_to work_path(work_id)
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
      rescue ActiveRecord::RecordNotUnique
        flash[:status] = :warning
        flash[:message] = "A problem occurred: Could not upvote"
        flash[:notice] = "No vote"

        redirect_back(fallback_location: root_path)
      end
    else
      flash[:status] = :warning
      flash[:message] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: root_path)
    end
  end

  def vote_params
    params.require(:vote).permit(:user_id, :work_id)
  end
end
