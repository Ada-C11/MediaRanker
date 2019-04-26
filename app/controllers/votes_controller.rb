class VotesController < ApplicationController
  def create
    @vote = Vote.new
    work_id = params[:work_id]
    if session[:user_id]
      user_id = session[:user_id]
      @vote.user_id = user_id
      @vote.work_id = params[:work_id]
      #   if Vote.check_unique_work(user_id, work_id)
      begin
        @vote.save
        redirect_to works_path
      rescue ActiveRecord::RecordNotUnique
        flash[:status] = :error
        flash[:message] = "user: has already voted for this work"
        redirect_to work_path(work_id)
      end
    else
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must log in to do that."
      redirect_to work_path(work_id)
    end
  end

  def vote_params
    params.require(:vote).permit(:user_id, :work_id)
  end
end
