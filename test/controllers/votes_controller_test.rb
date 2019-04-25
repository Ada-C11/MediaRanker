require "test_helper"

describe VotesController do
  describe "create" do
    it "logged in user can vote" do
      user = perform_login(users(:user_one))
      work = works(:work_one)

      # Arrange
      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      # Act-Assert
      expect {
        post work_votes_path(work.id), params: vote_hash
      }.must_change "Vote.count", 1

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end

    it "not logged in user cannot vote" do
      user = perform_login(users(:user_one))
      work = works(:work_one)

      post logout_path

      # Arrange
      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      # Act-Assert
      expect {
        post work_votes_path(work.id), params: vote_hash
      }.wont_change "Vote.count"

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end
  end
end
