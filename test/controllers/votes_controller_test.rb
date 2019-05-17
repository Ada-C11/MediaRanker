require "test_helper"

describe VotesController do
  describe "upvote" do
    it "allows a logged-in user to upvote a work" do
      work = works(:one)
      perform_login
      expect {
        post upvote_path(work.id)
      }.must_change "Vote.count", 1

      must_respond_with :redirect
      must_redirect_to works_path

      expect(flash[:success]).must_equal "Successfully upvoted!"
    end

    it "doesn't allow the user to upvote the same work more than once" do
      work = works(:one)
      perform_login

      post upvote_path(work.id)

      expect {
        post upvote_path(work.id)
      }.wont_change "Vote.count"

      must_respond_with :redirect
      must_redirect_to works_path

      expect(flash[:error]).must_equal "You have already upvoted this work!"
    end

    it "user needs to log in to be able to upvote" do
      work = works(:one)

      expect {
        post upvote_path(work.id)
      }.wont_change "Vote.count"

      must_respond_with :redirect
      must_redirect_to works_path

      expect(flash[:error]).must_equal "You need to log in to be able to upvote!"
    end
  end
end
