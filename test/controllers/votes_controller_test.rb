require "test_helper"

describe VotesController do
  describe "create" do
    it "upvotes" do
      user = perform_login(User.first)
      work = Work.first

      vote_data = {
        vote: {
          work_id: work.id,
          user_id: user.id,
        },
      }

      # Act-Assert
      expect {
        post upvote_work_path(work.id), params: vote_hash
      }.must_change "Vote.count", 1

      must_respond_with :redirect
      must_redirect_to user_path(user.id)
    end
  end
end
