class VotesController < ApplicationController
  def create
    work = Work.find_by(id: params[:id])
    user = User.find_by(id: session[:user_id])

    vote = Vote.new(date: Date.today, user_id: user.id, work_id: work.id)
    success = vote.save
    if success
      flash[:success] = "Upvoted successfully"
      redirect_to work_path
    else
      flash[:error] = "Upvote was not successful"
      redirect_to work_path
    end
  end
end
