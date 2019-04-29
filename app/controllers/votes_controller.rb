class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])

    if !@user
      flash[:warning] = "A problem occurred: You must log in to do that"
    elsif @user.works.find_by(id: params[:work_id])
      flash[:failure] = "Could not upvote"
    else
      @user.works << @work
      flash[:success] = "Successfully upvoted!"
    end
    redirect_back(fallback_location: root_path)
  end
end
