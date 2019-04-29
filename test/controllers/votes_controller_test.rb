require "test_helper"

describe VotesController do
  describe "upvote" do
    it "must be able to vote for a work" do
      user = users(:one)
      work = works(:album)

      logged_in_user = perform_login

      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      expect { post upvote_path(work.id), params: vote_hash }.must_change "Vote.count", 1
    end

    it "Will give an error if the user has already voted for a work" do
      user = users(:one)
      work = works(:album)

      logged_in_user = perform_login

      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      post upvote_path(work.id), params: vote_hash
      post upvote_path(work.id), params: vote_hash

      expect(flash[:duplicate_vote]).must_equal "user: has already voted for this work"
    end

    it "will not allow a user to vote if they have not logged in" do
      user = users(:one)
      work = works(:album)

      vote_hash = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      post upvote_path(work.id), params: vote_hash

      expect(flash[:error]).must_equal "You must log in to do that"
    end
  end
end
