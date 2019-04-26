class VotesController < ApplicationController
  def create
    work_id = params[:work_id]
    work = Work.find_by(id: work_id)
    user = User.find_by(id: session[:user_id])
    vote = Vote.new(work: work, user: user)

    successful = vote.save
    if successful
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"
    end
    redirect_to work_path(work_id)
  end
end
