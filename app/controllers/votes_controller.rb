class VotesController < ApplicationController
  def create
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote!"
      redirect_back(fallback_location: root_path)
      return
    end

    @work = Work.find_by(id: params[:work_id])
    @user = User.find_by(id: session[:user_id])
    @vote = Vote.new(user_id: @user.id, work_id: @work.id)

    if @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "A problem occured. Try voting again."
      flash[:messages] = @vote.errors
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote!"
      redirect_back(fallback_location: root_path)
      return
    end
    @vote = Vote.find_by(id: params[:id])

    unless @vote
      flash[:error] = "There was a problem finding your vote for this work"
      redirect_back(fallback_location: root_path)
      return
    end

    if @vote.destroy
      binding.pry
      flash[:success] = "Successfully removed your vote"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "There was a problem deleting your vote"
      redirect_back(fallback_location: root_path)
    end
  end
end
