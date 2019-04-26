require "test_helper"

describe VotesController do
  describe "create" do
    let(:work) {
      works(:custom1)
    }

    let(:user) {
      User.first
    }

    let (:login) {
      login_data = {
        user: {
          username: User.first.username,
        },
      }
      post login_path, params: login_data
    }

    let (:vote) {
      votes(:custom1)
    }

    it "creates a new vote" do
      login

      expect {
        post work_votes_path(work.id)
      }.must_change "Vote.count", 1
      must_redirect_to works_path
      vote = Vote.last
      expect(vote.user_id).must_equal session[:user_id]
      expect(vote.work_id).must_equal work.id
    end

    it "flashes an error if user is not logged in before voting" do
      expect {
        post work_votes_path(work.id)
      }.wont_change "Vote.count"

      must_redirect_to work_path(work.id)
      check_flash(:error)
    end

    it "requires a vote to be unique (a user cannot upvote medium more than once)" do
      login
      work_id_dup = Work.last.id
      expect {
        post work_votes_path(work_id_dup)
      }.wont_change "Vote.count"
      must_redirect_to work_path(work_id_dup)
      check_flash(:error)
    end
  end
end
