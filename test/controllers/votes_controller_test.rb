require "test_helper"

describe VotesController do
  let(:user) { users(:three) }
  let(:work) { works(:one) }
  describe "Votes#create" do
    it "will create a vote if logged in" do
      username = user.username
      params = { user: { username: username } }
      post login_user_path params: params
      expect {
        post work_votes_path(work.id)
      }.must_change "Vote.count", 1

      expect(work.users.include?(user)).must_equal true
      expect(user.works.include?(work)).must_equal true
    end
  end
end
