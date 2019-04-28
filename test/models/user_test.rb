require "test_helper"

describe User do
  before do
    @user = User.new({ username: "new user" })
  end
  describe "Validations" do
    it "Validates with good data" do
      result = @user.valid?

      expect(result).must_equal true
    end

    it "Wont validate a user without a username" do
      @user.username = nil
      result = @user.valid?

      expect(result).must_equal false
    end

    it "Wont validate a a user with a non unique username" do
      @user.save
      new_user = User.new({ username: "new user" })

      result = new_user.valid?

      expect(result).must_equal false
    end
  end

  describe "Relationships" do
    it "can add a vote through votes" do
      vote = votes.first
      @user.votes << vote

      expect(@user.votes).must_include vote
      expect(vote.user_id).must_equal @user.id
    end
  end
end
