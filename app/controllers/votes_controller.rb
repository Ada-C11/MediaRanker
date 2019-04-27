class VotesController < ApplicationController
  def upvote
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "You need to log in to be able to upvote!"
    else
      work_id = params[:id]
      date = Date.today
      user_id = user.id
      vote = Vote.upvote(date: date, work_id: work_id, user_id: user_id)

      if vote
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "You have already upvoted this work!"
      end
    end

    redirect_back fallback_location: works_path
  end
end
