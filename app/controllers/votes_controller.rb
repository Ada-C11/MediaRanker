class VotesController < ApplicationController

  def create
  
    work = Work.find(params[:work_id])
    user = User.find(session[:user_id])
    @vote = Vote.new(work_id: params[:work_id], user_id: session[:user_id])
    
    @vote.save
    
    unless @vote
      render :new
      flash[:error] = "Item can't be created at this time."
    else
      flash[:success] = "#{@vote.title} has been successfully added."
      
      redirect_to work_path(@vote.id)
    end
  end
  

end
