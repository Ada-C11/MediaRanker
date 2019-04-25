class VotesController < ApplicationController
  def upvote
    @vote = Vote.new
    @vote.users_id = User.find_by(session[:user_id])
    @vote.works_id = params[:id] #should be on that page
  end
end
