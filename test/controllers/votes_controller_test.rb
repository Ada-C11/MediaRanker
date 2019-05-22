require "test_helper"

describe VotesController do
  before do
    @work = Work.first
    @user = User.first
  end
  describe "upvote" do
    it "requires login and redirects if not logged in" do
      post upvote_path(@work)
      must_respond_with :redirect
      check_flash(:warning)
    end

    it "flashes a warning if the work id is invalid" do
      perform_login

      post upvote_path(123456)
      check_flash(:warning)
    end

    it "increases the number of votes, adds references when successful" do
      perform_login(@user)

      expect {
        post upvote_path(@work)
      }.must_change "Vote.count", 1
      check_flash

      expect(Vote.last.user_id).must_equal @user.id
      expect(Vote.last.work_id).must_equal @work.id
    end

    it "won't let a user vote more than once for the same work" do
      perform_login(@user)
      post upvote_path(@work)
      expect {
        post upvote_path(@work)
      }.wont_change "Vote.count"
      check_flash(:warning)
    end
  end

  describe "destroyed by association with deleted work" do
    before do
      @work = Work.first
      @user = User.first
    end

    it "reduces the vote count when an associated work is destroyed" do
      perform_login(@user)

      post upvote_path(@work)
      expect {
        delete work_path(@work)
      }.must_change "Vote.count", -1
    end
  end
end
