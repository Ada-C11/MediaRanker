require "test_helper"

describe User do
  describe "Validations" do
    before do
      @user = User.new({ username: "new user" })
    end
    it "Validates with good data" do
      result = @user.valid?

      expect(result).must_equal true
    end

    it "Wont validate a user a blank username" do
      @user.username = " "
      result = @user.valid?

      expect(result).must_equal false
    end

    it "Wont validate a user without a username" do
      @user.username = nil
      result = @user.valid?

      expect(result).must_equal false
    end
  end
end
