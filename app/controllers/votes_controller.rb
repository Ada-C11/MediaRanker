class VotesController < ApplicationController
  def create
    if session[:user_id]
      user = User.find_by(id: session[:user_id])
      work = Work.find_by(id: params[:work_id])
      user_votes = user.votes
      work_votes = work.votes

      user_votes.each do |vote|
        if work_votes.include?(vote)
          flash[:status] = :error
          flash[:message] = "You have already voted for this media"
          redirect_back(fallback_location: root_path)
          return
        end
      end
    
      vote = Vote.new(
        work_id: params[:work_id],
        user_id: session[:user_id],
      )
      
      if vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_back(fallback_location: root_path)
      
        user.votes << vote
        work.votes << vote
      end

    else
      flash[:error] = "A problem occurred: You must login to do that"
      redirect_back(fallback_location: root_path)
    end
  end
end
