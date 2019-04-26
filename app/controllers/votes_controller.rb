class VotesController < ApplicationController
  def create
    # if Vote.find_by(user_id: session[:user_id], work_id: params[:work_id])
    # flash[:error] = "You can't vote twice ~~"
    # redirect_to works_path
    # else
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    is_successful = @vote.save

    if is_successful
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    else
      flash[:alert] = "A problem occurred: Could not upvote"

      @vote.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_to works_path
      # end
    end
  end
end
