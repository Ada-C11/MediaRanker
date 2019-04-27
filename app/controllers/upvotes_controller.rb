class UpvotesController < ApplicationController
  
  def create
    current_user_id = session[:user_id]

    unless current_user_id
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to do that."
      redirect_back(fallback_location: root_path)
      return
    end

    #finds the work in the database and checks to see if user has voted for it already
    corresponding_votes = Upvote.where(work_id: params[:work_id])
    not_found = corresponding_votes.find_by(user_id: current_user_id).present?


    if not_found
      flash[:status] = :error
      flash[:message] = "You already upvoted this item!"
      redirect_back(fallback_location: root_path)
    else 
      vote = Upvote.new(user_id: current_user_id, work_id: params[:work_id])
      if vote 
        flash[:status] = [:success]
        flash[:message] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
        vote.save
      else
        flash[:status] = [:error]
        flash[:message] = "An error has occurred, unable to save vote"
        redirect_back(fallback_location: root_path)
      end
    end

    
  end
  
end

