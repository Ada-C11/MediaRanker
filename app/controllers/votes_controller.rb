class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])
    @work.users << @user
  end
end
