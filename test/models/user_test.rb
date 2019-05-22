require "test_helper"

describe User do
  describe "validation" do
    before do
      @user = User.first
    end

    it "must be valid" do
      value(@user).must_be :valid?
    end

    it "needs a username" do
      @user.username = nil
      expect(@user.valid?).must_equal false
      expect(@user.errors.messages).must_include :username
    end
  end
end
