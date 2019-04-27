class VotesController < ApplicationController
  def upvote
    user_id = session[:user_id]
    work_id = params[:id]
    date = Date.today
    vote = Vote.upvote(date: date, work_id: work_id, user_id: user_id)

    if vote
      # if vote.save
      flash[:success] = "Successfully upvoted!"
    else
      flash[:error] = "You have already upvoted this work!"
    end
    redirect_back fallback_location: works_path
  end

  # def create
  #   date = Date.today
  #   user_id = session[:user_id]
  #   work_id = params[:id]
  #   vote = Vote.new(date: date,
  #                   work_id: work_id,
  #                   user_id: user_id)
  #   if vote.save
  #     flash[:success] = "Work has been voted!"
  #   else
  #     vote.errors.messages.each do |field, messeges|
  #       flash.now[field] = messages
  #     end
  #   end
  # end

  #   private

  #   def vote_params
  #     return params.require(:vote).permit(:date, :work_id, :user_id)
  #   end
end
