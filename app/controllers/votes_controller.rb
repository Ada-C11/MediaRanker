class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    is_successful = @vote.save

    if is_successful
      flash[:success] = "Upvoted!"
    elsif session[:user_id].nil?
      flash[:failure] = "You must be logged in to upvote a work"
    else
      @vote.errors.messages.each do |field, messages|
        flash[field] = messages
      end
    end
    redirect_to work_path(params[:work_id])
  end
end
