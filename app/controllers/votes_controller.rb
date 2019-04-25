class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:error] = "You must be logged in to vote"
      redirect_to login_path
    else
      Vote.create(user_id: session[:user_id], work_id: @work.id)
      flash[:status] = :success
      flash[:message] = "Successfully voted!"
      redirect_to work_path(@work)
    end
  end
end
