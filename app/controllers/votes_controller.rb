class VotesController < ApplicationController
  def upvote
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    if @vote.save
      flash[:status] = :success
      flash[:message] = "Successfully upvoted!"

      redirect_to work_path(params[:work_id])
    else
      flash[:status] = :failure
      if @vote.errors.messages.include?(:user_id)
        flash[:message] = "You must log in to do that"
      else @vote.errors.messages.include?(:user)
        flash[:message] = "Could not upvote"
        flash[:details] = @vote.errors.messages
      end
      redirect_to root_path
    end
  end
end
