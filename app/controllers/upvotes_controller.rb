class UpvotesController < ApplicationController
  
  def create
    current_user = session[:user_id]

    unless current_user
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to do that."
      redirect_back(fallback_location: root_path)
      return
    end

      media = Vote.where(work_id: params[:work_id])
      already_voted = media.users.find_by(id: user_id)

    if !already_voted
      vote = Vote.new(user_id: current_user, work_id: params[:work_id])
      vote.save
    else
      flash[:status] = :success
      flash[:message] = "You already upvoted this item!"
    end

    
  end
  
  private
    def valid_vote(user_id)
      return already_voted
    end
end
