class VotesController < ApplicationController
  def create
    find_user
    if find_user.nil?
      flash[:error] = "You must be logged in to vote."
    else
      vote = Vote.new(user_id: @user.id, work_id: params[:work_id])
      if vote.save
        flash[:success] = "Successfully upvoted!"
      else
        flash[:error] = "Error - upvote unsuccessful. You can't vote for the same media twice."
      end
      # @user.errors.messages.each do |field, messages|
      #   flash.now[field] = messages
      # end
      # ApplicationController.render(
      #   template: 'works/index',
      #   assigns: { user: @user }
      # render :works, status: :bad_request
    end
    redirect_to works_path
  end

  private

  def find_user
    @user = User.find_by(id: session[:user_id])
  end
end
