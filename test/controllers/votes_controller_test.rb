require "test_helper"

describe VotesController do
  describe "create" do
    it "creates a new vote" do
      perform_login

      expect {
        post vote_path(works(:summer).id)
      }.must_change "Vote.count", +1

      must_redirect_to work_path
    end

    it " does not create a new vote when there is no user logged in" do
      expect {
        post vote_path(works(:summer).id)
      }.wont_change "Vote.count"

      must_redirect_to work_path
    end


    it " does not create a new vote with a work that does not exist" do
      perform_login
      expect {
        post vote_path(-1)
      }.wont_change "Vote.count"

      must_redirect_to work_path
    end

    it "does not create a vote for a work that has already been voted on by that user" do
      perform_login
      post vote_path(works(:summer).id)
      expect {
        post vote_path(works(:summer).id)
      }.wont_change "Vote.count"

      must_redirect_to work_path

    end

  end

  
end
