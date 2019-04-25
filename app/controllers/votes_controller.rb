class VotesController < ApplicationController

  def create
  
    work = Work.find(params[:work_id])
    user = User.find(session[:user_id])
    @vote = Vote.new(work_id: params[:work_id], user_id: session[:user_id])
    
    @vote.save
    
    unless @vote
      render :new
      flash[:error] = "Vote not counted"
    else
      flash[:success] = "Thanks for your vote!"
      
      redirect_to work_path(work.id)
    end
  end
  

end
