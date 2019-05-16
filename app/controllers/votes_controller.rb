class VotesController < ApplicationController
  def add_vote
    @user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:id])

    if @user && !@user.already_voted?(work)
      vote = Vote.create!(user: @user, work: work)
      if vote
        flash[:success] = "Successfully upvoted!"
        redirect_to work_path(work)
      else
        flash[:error] = "Error saving the vote: #{vote.errors.messages}"
        redirect_to work_path(work)
      end
    elsif @user && @user.already_voted?(work)
      flash[:error] = "A problem occurred: You have already voted for this work"
      redirect_to work_path(work)
    else
      flash[:error] = "A problem occurred: You must log in to do that"
      redirect_to work_path(work)
    end
  end
end
