class VotesController < ApplicationController
  def create
    @vote = Vote.new

    @vote.user_id = session[:user_id]
    @vote.work_id = params[:work_id]

    is_successful = @vote.save

    if is_successful
      flash[:success] = "Upvoted!"
      redirect_to work_path(params[:work_id])
    else
      @vote.errors.messages.each do |field, messages|
        flash.now[field] = messages
      end
      render :new, status: :bad_request
    end
  end
end
