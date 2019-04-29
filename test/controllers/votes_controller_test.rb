require "test_helper"

describe VotesController do
  describe "create" do
    it "should create new vote if logged in and has not voted for work yet" do
      perform_login
      work = works(:hp5)
      user = users(:dee)

      vote_hash = {
        vote: {
          user: user,
          work: work,
        },
      }
      expect {
        post work_votes_path(work.id), params: vote_hash
      }.must_change "Vote.count", 1

      must_respond_with :redirect
    end

    it "should not create new votes if not logged in" do
      work = works(:hp5)
      user = users(:dee)

      vote_hash = {
        vote: {
          user: user,
          work: work,
        },
      }
      expect {
        post work_votes_path(work.id), params: vote_hash
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end

    it "should not create if logged in but already voted for that work" do
      perform_login

      work = works(:hp5)
      user = users(:dee)

      vote_hash = {
        vote: {
          user: user,
          work: work,
        },
      }

      post work_votes_path(work.id), params: vote_hash

      expect {
        post work_votes_path(work.id), params: vote_hash
      }.wont_change "Vote.count"

      must_respond_with :redirect
    end
  end
end
