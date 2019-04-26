class UpvoteController < ApplicationController
  
  def upvote
    current_user = session[:user_id]

    unless current_user
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to do that."
      redirect_to :back
      return
    end

    if valid_vote(current_user)
      vote = Vote.new(user_id: current_user, work_id: params[:id])
      vote.save
    else
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
    end
  end
end

private
  def valid_vote(user_id)
    media = Vote.where(work_id: params[:id])
    already_voted = media.users.find_by(id: user_id)

    return already_voted
  end