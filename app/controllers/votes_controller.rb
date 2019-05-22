class VotesController < ApplicationController

  def new
    @vote = Vote.new
  end

  def create
    work = Work.find_by(id: params[:id])
      if session[:user_id] && work
        user = User.find_by(id: session[:user_id])
        vote = Vote.new(date: Date.today, user_id: user.id, work_id: work.id )
        success = vote.save
        if success
         flash[:success] = "Upvoted successfully"
          redirect_to work_path
        else
          flash[:error] = "You may not vote for the same work twice!"
          redirect_to work_path
        end
      else
        flash[:error] = "You have to be logged in to vote!"
        redirect_to work_path
      end
  end

  private

  def vote_params
    return params.require(:vote).permit(:work_id)
  end


end
