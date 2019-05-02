class VotesController < ApplicationController
  def index
  end

  def create
  end

  private

  def work_params
    return params.require(:vote).permit(:user_id, :work_id)
  end
end
