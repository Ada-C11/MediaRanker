require "pry"

class VotesController < ApplicationController
  def create
    work_id = params[:work_id]
    work = Work.find_by(id: work_id)
    user = User.find_by(id: session[:user_id])
    unless user
      flash[:status] = :error
      flash[:message] = "A problem occured: You must log in to do that"
      redirect_to work_path(work_id)
      return
    end
    vote = Vote.new(work: work, user: user)

    successful = vote.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
    else
      flash[:status] = :error
      flash[:message] = "A problem occurred: Could not upvote. User: has already voted for this work"
    end
    redirect_to work_path(work_id)
  end
end
