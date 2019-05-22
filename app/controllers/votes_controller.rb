class VotesController < ApplicationController
  def upvote
    if !session[:user_id]
      flash[:status] = :warning
      flash[:message] = "A problem occurred: you must log in to do that"
      redirect_back(fallback_location: works_path)
      return
    end

    user_id = session[:user_id]

    if Work.find_by(id: params[:id])
      work_id = params[:id]

      @vote = Vote.create(user_id: user_id, work_id: work_id)
      if !@vote.valid?
        flash[:status] = :warning
        flash[:message] = "User #{User.find_by(id: user_id).username} has already upvoted this work"

        redirect_back(fallback_location: works_path)
        return
      end
    else
      flash[:status] = :warning
      flash[:message] = "Invalid work id"
      redirect_to root_path
      return
    end
    flash[:status] = :success
    flash[:message] = "Successfully upvoted!"
    redirect_back(fallback_location: works_path)
  end
end
