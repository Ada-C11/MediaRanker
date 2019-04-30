require "test_helper"

describe VotesController do

  describe "create" do
    it "creates a vote." do
      # skip
      user = users(:faiza)
      work = works(:gameofthrones)

      logged_in_user = perform_login

      vote_data = {
        vote: {
          user_id: user.id,
          work_id: work.id,
        },
      }

      expect { post upvote_path(work_id: work.id), params: vote_data }.must_change "Vote.count", 1
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
