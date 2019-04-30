require "test_helper"

describe VotesController do

  describe "create" do
    it "creates a vote." do
      skip

      vote = Vote.new(user_id: users(:jane), work_id: works(:therook))
      expect(vote).must_be :valid?
      
      start_count = Vote.count
      
      vote.save


      post upvote_path, params: vote

      Vote.count.must_equal start_count + 1
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
