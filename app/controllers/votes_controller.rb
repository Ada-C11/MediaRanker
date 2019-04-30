class VotesController < ApplicationController
  def create
    work_id = params[:work_id]
    work = Work.find_by(id: work_id)
    user = User.find_by(id: session[:user_id])
    unless user
      flash[:status] = :warning 
      flash[:message] = "A problem occured: You must log in to do that"
      return 
    end
    vote = Vote.new(work: work, user: user)

    successful = vote.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
    else
      flash[:status] = :warning
      flash[:message] = "A problem occurred: Could not upvote. User: has already voted for this work"
    end
  end
end
