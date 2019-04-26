class UpvoteController < ApplicationController
  
  def upvote
    current_user = session[:user_name]

    unless current_user
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to do that."
      redirect_to :back
      return
    end

  end
end
