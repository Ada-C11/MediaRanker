class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    if Vote.find_by(user_id: session[:user_id], work_id: params[:work_id]).nil?
      @vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "you can only vote for that work once!"
    end

    redirect_to "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
    #can I just re render somehow and use flash.now instead of redirect?
  end
end
