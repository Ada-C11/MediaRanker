class VotesController < ApplicationController
  def create
    if session[:user_id]
      work_votes = Work.find_by(id: params[:work_id]).vote_ids
      user_votes = User.find_by(id: session[:user_id]).vote_ids
      work_votes.each do |w|
        user_votes.each do |u|
          if w == u
            flash[:error] = "user: has already voted for this work"
            redirect_to work_path(params[:work_id])
            return
          end
        end
      end

      vote = Vote.new(
        work_id: params[:work_id],
        user_id: session[:user_id],
      )
      vote.save

      Work.find_by(id: params[:work_id]).vote_ids << vote.id
      User.find_by(id: session[:user_id]).vote_ids << vote.id
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "You must login to vote"
    end
    redirect_to works_path
  end
end
