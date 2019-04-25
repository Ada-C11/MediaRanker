class VotesController < ApplicationController
  def create
    @vote = Vote.new
    if session[:user_id]
      user_id = session[:user_id]
      @vote.user_id = user_id
      @vote.work_id = params[:work_id]
      check_unique_work(user_id, work_id)
      work_id = params[:work_id]
      p @vote.work_id
      @vote.save
      redirect_to works_path
    else

    end
  end

  def vote_params
    params.require(:vote).permit(:user_id, :work_id)
  end
end
