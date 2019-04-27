require "test_helper"

describe VotesController do
  let (:work) { works.first }
  describe "create" do
    it "Creates a new vote if user is logged in and has not voted for it before" do
      perform_login

      expect {
        post work_votes_path(work)
      }.must_change "Vote.count", +1

      must_respond_with :redirect
      must_redirect_to work_path(work)
    end
    it "Does not create vote if user has already voted for work" do
      perform_login

      post work_votes_path(work)

      expect {
        post work_votes_path(work)
      }.wont_change "Vote.count"

      expect(flash[:status]).must_equal :warning
    end
    it "Flashes error status if no user logged in" do
      expect {
        post work_votes_path(work)
      }.wont_change "Vote.count"

      expect(flash[:status]).must_equal :warning
    end
  end
end
