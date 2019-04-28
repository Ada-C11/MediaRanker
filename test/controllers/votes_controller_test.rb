require "test_helper"

describe VotesController do
  let(:work) { works(:harry_one) }

  describe "create" do
    it "can create a vote for a user for a given work" do
      logged_in_user = perform_login

      expect {
        post work_votes_path(work.id)
      }.must_change "Vote.count", 1

      expect(flash[:success]).must_equal "Successfully upvoted!"
      must_respond_with :redirect
      # only tests the fallback location, is there a test for redirect back? Internet said 'nah'.
      must_redirect_to root_path
    end

    it "will not allow a user to vote unless they are logged in" do
      expect {
        post work_votes_path(work.id)
      }.wont_change "Vote.count"

      expect(flash[:failure]).must_equal "You must log in to do that"
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "will not allow a user to vote for the same work more than once" do
      logged_in_user = perform_login
      logged_in_user.works << work

      expect {
        post work_votes_path(work.id)
      }.wont_change "Vote.count"

      expect(flash[:failure]).must_equal "Could not upvote"
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
