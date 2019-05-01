require "test_helper"

describe User do
  describe "validations" do
    before do
      @user = User.first
    end

    it "must be valid" do
      value(@user).must_be :valid?
    end

    it "needs a name" do
      @user.name = nil
      result = @user.valid?

      expect(result).must_equal false
    end

    it "won't allow a user with a duplicate name" do
      @user.save
      new_user = User.new({ name: "new user" })

      result = new_user.valid?

      expect(result).must_equal false
    end
  end

  describe "relations" do
    it "can add a vote through votes" do
      vote = votes.first
      @user.votes << vote

      expect(@user.votes).must_include vote
      expect(vote.user_id).must_equal @user.id
    end
  end
end
