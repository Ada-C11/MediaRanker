class UpvotesController < ApplicationController
  
  def create
    current_user_id = session[:user_id]

    unless current_user_id
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to do that."
      redirect_back(fallback_location: root_path)
      return
    end

    #finds the work in the database to see if user has voted already
    already_voted = Upvote.find_by(user_id: current_user_id, work_id: params[:work_id]).present?


    if already_voted
      flash[:status] = :error
      flash[:message] = "You already upvoted this item!"
    else 
      vote = Upvote.new(user_id: current_user_id, work_id: params[:work_id])
      if vote 
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
        vote.save
      else
        flash[:status] = :error
        flash[:message] = "An error has occurred, unable to save vote"
      end
    end
    redirect_back(fallback_location: root_path)
  end
end

