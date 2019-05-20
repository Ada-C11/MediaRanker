require "test_helper"

describe VotesController do
  describe "create" do
    before do
      @user = perform_login
      @work = works(:one)
    end

    it "identifies the correct user" do
      expect(@user.id).must_equal session[:user_id]
    end

    it "gives an error if the user voted for that work already" do
      #first vote
      post work_votes_path(@work.id) 

      #second vote on same work
      expect {
        post work_votes_path(@work.id)
      }.wont_change "Vote.count"

      must_respond_with :redirect
      expect(flash[:message]).must_equal "You have already voted for this media"
    end

    it "can create a vote" do
      expect {
        post work_votes_path(@work.id)
      }.must_change "Vote.count", +1
      
      expect(flash[:success]).must_equal "Successfully upvoted!"
    end

    it "can add a vote to the user/work votes collection" do
      post work_votes_path(@work.id)

      expect(@user.votes.count).must_equal 1
      expect(@work.votes.count).must_equal 1
    end

    it "gives an error if the user is not logged in" do
      post logout_path

      expect {
        post work_votes_path(@work.id)
      }.wont_change "Vote.count"

      expect(flash[:error]).must_equal "A problem occurred: You must login to do that"
    end
  end
end
