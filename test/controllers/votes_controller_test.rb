require "test_helper"

describe VotesController do
  describe "create" do
    before do
      @user = perform_login
      @work = works(:one)
    end

    it "will save a new vote and redirect if given valid inputs" do
      expect {
        post work_votes_path(@work.id)
      }.must_change "Vote.count", 1

      expect(flash[:success]).must_equal "Successfully upvoted!"
      expect(@work.vote_ids.last).must_equal Vote.last.id
      expect(@user.votes.last).must_equal Vote.last
      must_respond_with :redirect
    end

    it "should not allow user to vote on media that they've already upvoted" do
      post work_votes_path(@work.id)

      expect {
        post work_votes_path(@work.id)
      }.wont_change "Vote.count"

      expect(flash[:error]).must_equal "Error - upvote unsuccessful. You can't vote for the same media twice."
    end

    it "should not allow a user to vote if they aren't logged in" do
      post logout_path

      post work_votes_path(@work.id)

      expect(flash[:error]).must_equal "You must be logged in to vote."
    end
  end
end
