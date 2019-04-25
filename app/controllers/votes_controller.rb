class VotesController < ApplicationController

    def create
        vote = Vote.create(vote_params)
    end

    def vote_params
        params.require(:vote).permit(:user_id, :work_id)
    end
end
