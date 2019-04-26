require "test_helper"

describe User do
  describe "validations" do
    before do
      @user = User.new(username: "username")
    end

    it "is valid when username is present" do
      result = @user.valid?
      result.must_equal true
    end

    it "is not valid when username is absent" do
      @user.username = nil
      result = @user.valid?
      result.must_equal false
    end
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
