class VotesController < ApplicationController
  #   before_action :find_user, only: [:upvote]

  def upvote
    new_vote = Vote.new
    new_vote.user = User.find_by(id: session[:user_id])
    new_vote.work = Work.find_by(id: params[:id])

    if new_vote.user_id = session[:user_id]
      if new_vote.save
        flash[:success] = "Successfully upvoted!"
        redirect_to works_path
      else
        flash[:duplicate_vote] = "user: has already voted for this work"
        redirect_to works_path
      end
    else
      flash[:error] = "You must log in to do that"
      redirect_to works_path
    end
  end
end
