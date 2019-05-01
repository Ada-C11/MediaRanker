class UpvotesController < ApplicationController
  
  def create
    current_user_id = session[:user_id]

    if !current_user_id
      flash[:status] = :error
      flash[:message] = "A problem occurred: You must be logged in to vote."
      return redirect_back(fallback_location: root_path)
    elsif
      vote = Upvote.new(user_id: current_user_id, work_id: params[:work_id])
      if vote.save 
        flash[:status] = :success
        flash[:message] = "Successfully upvoted!"
      else
        flash[:status] = :error
        vote.errors.messages.each do |model, msg|
          msg.each do |message|
            flash[:message] = "A problem has occurred: #{model} #{message}"
          end
        end
      end
    end
    redirect_back(fallback_location: root_path)
  end
end

