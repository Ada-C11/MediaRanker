class VotesController < ApplicationController
  def upvote
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    if @vote.save
      flash[:message] = "Successfully upvoted!"
      redirect_back(fallback_location: works_path)
    else
      if @vote.errors.messages.include?(:user_id)
        flash[:error] = "You must log in to do that"
      else @vote.errors.messages.include?(:user)
        flash[:error] = "Could not upvote"
      end
      redirect_to works_path
    end
  end
end
