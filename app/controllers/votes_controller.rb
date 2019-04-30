class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:error] = "You must be logged in to vote"
      redirect_to login_path
    else
      vote = Vote.new(user_id: session[:user_id], work_id: @work.id)
      # unless Vote.find_by(user_id: session[:user_id], work_id: @work.id)
      unless !vote.valid?
        vote.save

        flash[:status] = :success
        flash[:message] = "Successfully voted!"
        redirect_to work_path(@work)
      else
        flash[:error] = "You can not vote twice for the same work"
        redirect_to works_path
      end
    end
  end
end
