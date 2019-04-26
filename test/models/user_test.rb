require "test_helper"

describe User do
  it "must be valid" do
    user = users(:user_one)

    valid_user = user.valid?

    expect(valid_user).must_equal true
  end

  describe "validations" do
    it "requires a username" do
      # Arrange
      Vote.delete_all
      User.delete_all
      user = User.new(username: "")

      # Act
      valid_user = user.valid?

      # Assert
      expect(valid_user).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "requires a unique username" do
      # Arrange
      Vote.delete_all
      User.delete_all
      user = User.create(username: "test")
      user2 = User.new(username: "test")

      # Act
      valid_user = user2.valid?

      # Assert
      expect(valid_user).must_equal false
      expect(user2.errors.messages).must_include :username
      expect(user2.errors.messages[:username]).must_equal ["has already been taken"]
    end
  end
end
