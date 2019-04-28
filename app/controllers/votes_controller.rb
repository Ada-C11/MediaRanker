class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])
    @vote = @user.works.find_by(id: params[:work_id])

    if !@user
      flash[:failure] = "You must log in to do that"
    elsif @vote
      flash[:failure] = "Could not upvote"
    else
      @work.users << @user
      flash[:success] = "Successfully upvoted!"
    end
    redirect_back(fallback_location: root_path)
  end
end
