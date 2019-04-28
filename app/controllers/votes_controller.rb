class VotesController < ApplicationController

  def create
  
    work = Work.find(params[:work_id])
    
    unless session[:user_id]
      flash[:error] = "You must be logged in to vote."
      redirect_back(fallback_location: works_path)
    else
      user = User.find(session[:user_id])
    
      @vote = Vote.new(work_id: params[:work_id], user_id: session[:user_id])

    
      if work.user_ids.include?(user.id)
        flash.now[:error] = "HEY! You already voted for that. Try voting for something else."
        render 'home/index'
      else
        @vote.save
        flash[:success] = "Thanks for your vote!"
        
        redirect_back(fallback_location: works_path)
      end
    end
  end
  
  private
  def vote_params
    return params.require(:vote).permit(:user_id, :work_id)
  end

end
