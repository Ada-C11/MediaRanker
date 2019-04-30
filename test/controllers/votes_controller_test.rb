require "test_helper"

describe VotesController do

  describe "create" do
    it "creates a vote." do
      # skip

      #create vote
      vote = votes(:vote1)
      start_count = Vote.count
      # save vote
      vote.save

      # vote should be valid
      expect(vote).must_be :valid?
      post upvote_path, params: vote

      expect(Vote.count).must_equal start_count + 1
    end

    it "doesn't create a new vote when the user isn't logged in." do
      vote_data = {
        vote: {
          user: nil,
          work: works(:therook)
        }
      }
      Vote.new(vote_data[:vote]).wont_be :valid?
      start_work_count = Vote.count
      post upvote_path, params: vote_data
      must_respond_with :redirect
      must_redirect_to works_path

      Vote.count.must_equal start_work_count

    end
  end
end
