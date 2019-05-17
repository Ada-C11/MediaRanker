class VotesController < ApplicationController
  def create
    @vote = Vote.new(user_id: session[:user_id], work_id: params[:work_id])

    if session[:user_id] != nil
      if Vote.find_by(user_id: session[:user_id], work_id: params[:work_id]).nil?
        @vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "you can only vote for that work once!"
      end
    else
      flash[:error] = "you need to be logged in"
    end

    redirect_back(fallback_location: root_path)

    # redirect_to "http://www.youtube.com/watch?v=oHg5SJYRHA0"
    #can I just re render somehow and use flash.now instead of redirect?
  end
end
