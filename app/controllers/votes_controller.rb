class VotesController < ApplicationController
  def upvote
    @vote = Vote.new
    @vote.users_id = User.find_by(session[:user_id])
    @vote.works_id = Work.find_by(id: params[:id])
  end
end
