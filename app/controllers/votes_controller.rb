class VotesController < ApplicationController
  def upvote
    user_id = session[:user_id]
    work_id = params[:id]
    date = Date.today
    vote = Vote.upvote(date: date, work_id: work_id, user_id: user_id)

    if vote
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "You have already upvoted this work!"
    end
    redirect_back fallback_location: works_path
  end
end
