require "test_helper"

describe VotesController do
  describe "create (upvote)" do
    before do
      @vote = Vote.first
    end

    it "successfully upvotes" do
      work = Work.first

      perform_login
      expect {
        post work_votes_path(work)
      }.must_change "Vote.count", +1
      check_flash
      vote = Vote.last
      expect(vote.user_id).must_equal session[:user_id]
      expect(vote.work).must_equal work
  
    end

    it "rejects vote when not logged in" do
      work = Work.first
      expect {
        post work_votes_path(work)
      }.wont_change "Vote.count"

      check_flash(expected_status = :warning)

    end

    it "bans user upvoting same work twice" do
      user = @vote.user
      work = @vote.work 
      perform_login(user)

      expect {
        post work_votes_path(work)
      }.wont_change "Vote.count"

      check_flash(expected_status = :warning)

    end
  end
end
