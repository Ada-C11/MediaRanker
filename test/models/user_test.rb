require "test_helper"

describe User do
  let(:user) { User.new(username: "username") }

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe "relations" do
    it "has votes" do
      user = users(:bender)
      user.votes.must_include votes(:one)
    end

    it "can add votes" do
      user = User.new(username: "newuser")
      vote = Vote.new(user_id: user.id, work_id: Work.last.id)
      user.votes << vote
      user.votes.must_include vote
    end
  end
end
