class VotesController < ApplicationController
  def create
    user_id = session[:user_id]
    if !user_id
      session[:error] = "A problem occurred: You must log in to do that"
    else
      vote = Vote.new(user_id: user_id, work_id: params[:work_id])
      if vote.save
        session[:success] = "Successfully upvoted!"
      else
        session[:error] = "A problem occurred: Could not upvote"
        vote.errors.messages.each do |label, message|
          flash.now[label.to_sym] = message
        end
      end
    end
  end
end

# A problem occurred: Could not upvote
# user: has already voted for this work
