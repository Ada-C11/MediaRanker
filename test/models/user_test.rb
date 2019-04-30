require "test_helper"

describe User do
  let(:user) { users(:kim) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  describe "validations" do
    it "must have a username" do
      user.username = nil

      valid_user = user.valid?

      expect(valid_user).must_equal false

      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "must have a join date" do
      user.join_date = nil

      valid_user = user.valid?

      expect(valid_user).must_equal false

      expect(user.errors.messages).must_include :join_date
      expect(user.errors.messages[:join_date]).must_equal ["can't be blank"]
    end
  end

  describe "relations" do
  end
end
