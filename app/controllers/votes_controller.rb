class VotesController < ApplicationController
  before_action :find_user, only: [:upvote]

  def upvote
    # find_user method in application controller
    @work = Work.find_by(id: params[:id])

    @vote = Vote.new(user_id: @user.id, work_id: @work.id)

    if @user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to works_path
    else
      @vote.save
      flash[:success] = "Successfully upvoted!"
      redirect_to works_path
    end
  end
end
