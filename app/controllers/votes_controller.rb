class VotesController < ApplicationController
  def create
    unless session[:user_id]
      flash[:status] = :warning
      flash[:message] = "A problem occured: You must log in to do that"
      redirect_back(fallback_location: root_path)
      return
    end

    if Vote.find_by(user_id: session[:user_id], work_id: params[:work_id])
      flash[:status] = :warning
      flash[:message] = "You have already voted for this work"
      redirect_back(fallback_location: root_path)
      return
    else
      vote = Vote.new
      vote.user_id = session[:user_id]
      vote.work_id = params[:work_id]
      vote.save
      redirect_to work_path(params[:work_id])
      return
    end
  end
end
