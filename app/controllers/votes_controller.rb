class VotesController < ApplicationController
  def create
    if session[:user_id]
      @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])
      if Vote.find_by(user_id: session[:user_id], work_id: params[:work_id]).nil?
        @vote.save 
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "A problem occurred: Could not upvote"
      end
    else
      flash[:error] = "You need to be logged in"
    end
    redirect_to homepage_path
  end
end
