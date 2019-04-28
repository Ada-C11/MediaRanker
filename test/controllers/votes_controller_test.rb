require "test_helper"

describe VotesController do
  describe "create" do
    it "is possible to vote if logged in" do
      user = perform_login(User.first)
      work = Work.first

      # Arrange
      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      # Act-Assert
      expect {
        post upvote_work_path(work.id), params: vote_hash
      }.must_change "Vote.count", 1

      must_respond_with :redirect
      must_redirect_to user_path(user.id)
    end

    it "prohibits vote on same work more than once" do
      user = perform_login(User.first)
      work = Work.first

      # Arrange
      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      expect {
        post upvote_work_path(work.id), params: vote_hash
      }.must_change "Vote.count", 1

      expect {
        post upvote_work_path(work.id), params: vote_hash
      }.wont_change "Vote.count"

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end

    it "prohibits vote for logged out users" do
      user = perform_login(User.first)
      work = Work.first

      post logout_path

      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      expect {
        post upvote_work_path(work.id), params: vote_hash
      }.wont_change "Vote.count"

      must_respond_with :redirect
      must_redirect_to login_path
    end
  end
end
