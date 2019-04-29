class VotesController < ApplicationController
    def new
        @vote = Vote.new
    end

    def create
        @vote = Vote.new(:user_id, :work_id)

        if @vote.save
            flash[:success] = "Successfully upvoted!"
            redirect_to user_path(@user.id)
      
        else
            flash.now[:error] = "A problem occurred: Could not upvote"
            
            render :new, status: :bad_request
        end
    end
end
