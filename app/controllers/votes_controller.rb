class VotesController < ApplicationController
  def create
    user = User.find_by(id: session[:user_id])
    work = Work.find_by(id: params[:work_id])

    unless user.nil?
      @vote = Vote.new(
        work_id: params[:work_id],
        user_id: user.id,
      )
    else
      flash[:status] = :error
      flash[:message] = "You must log in first."
      redirect_to work_path(work.id)
      return
    end

    @vote.save

    redirect_to root_path
  end
end
