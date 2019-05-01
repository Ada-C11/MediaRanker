class VotesController < ApplicationController
  def create
    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])

    if !@user
      flash[:warning] = "A problem occurred: You must log in to do that"
    else
      vote = Vote.new(user: @user, work: @work)
      if vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:warning] = "A problem occurred: Could not upvote"
        vote.errors.messages.each do |field, messages|
          flash[field] = messages
        end
      end
    end
    redirect_back(fallback_location: root_path)
  end
end
