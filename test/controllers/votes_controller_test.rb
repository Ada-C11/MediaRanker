require "test_helper"

describe VotesController do
  describe "create" do 
    before do
      @user = perform_login
      @work = works(:moon)

      @vote = Vote.new(user_id: @user.id, work_id: @work.id)
    end
    
    it "will save a new vote and redirect if given valid inputs" do  
      Vote.delete_all
      expect {
        post work_votes_path(@work.id)
      }.must_change "@work.votes.count", +1
      
      expect(flash[:success]).must_equal "Thanks for your vote!"
      expect(@work.vote_ids.first).must_equal Vote.first.id
      expect(@user.vote_ids.first).must_equal Vote.first.id
      
      must_respond_with :redirect
    end

    it "should not allow user to vote on media that they've already voted on" do
      
      post work_votes_path(@work.id)

      expect {
        post work_votes_path(@work.id)
      }.wont_change "@work.votes.count"

      expect(flash[:error]).must_equal "HEY! You already voted for that. Try voting for something else."
    end

    it "should not allow a user to vote if they aren't logged in" do
      post logout_path

      post work_votes_path(@work.id)

      expect(flash[:error]).must_equal "You must be logged in to vote."
    end
  end
end
