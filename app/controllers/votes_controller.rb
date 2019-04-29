class VotesController < ApplicationController
  def create
    unless session[:user_id]
      flash[:alert] = "A problem occurred: You must log in to do that"
      redirect_back(fallback_location: works_path)
      return
    end

    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    is_successful = @vote.save

    if is_successful
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: works_path)
    else
      flash[:alert] = "A problem occurred: Could not upvote"

      @vote.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_back(fallback_location: works_path)
    end
  end
end
