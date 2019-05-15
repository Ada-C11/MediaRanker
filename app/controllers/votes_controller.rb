class VotesController < ApplicationController
  def create 
    @vote = Vote.new(
      user_id: 1,
      work_id: params[:work_id]
    )

    puts "WORK_ID IS: #{@vote.work_id}."
    puts "USER_ID IS: #{@vote.user_id}."

    if @vote.save
      flash[:success] = "Successfully voted for work with title \"#{Work.find_by(id: params[:work_id]).title}\""
      redirect_to works_path

    else
      flash[:error] = "A problem occured"

      redirect_back(fallback_location: root_path)
    end
  end
end
