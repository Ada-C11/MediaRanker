class VotesController < 
    def index
      @votes = Vote.all.sort_by(&:number_of_votes).reverse
      @users_votes = @votes.find(params[:user_id])
      @works_votes = @votes.find(params[:work_id])
  end

end
