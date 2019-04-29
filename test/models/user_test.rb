require "test_helper"

describe User do
  let(:user) { users(:one) }

  it "must be valid" do
    expect(user.valid?).must_equal true
  end

  describe "validations" do
    it "requires a username" do
      user.username = nil

      valid_user = user.valid?

      expect(valid_user).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "requires a unique username" do
      duplicate_user = User.new(username: user.username)

      expect(duplicate_user.save).must_equal false

      expect(duplicate_user.errors.messages).must_include :username
      expect(duplicate_user.errors.messages[:username]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "can have 0 votes" do
      user = users(:no_votes)

      votes = user.votes
      expect(votes.length).must_equal 0
    end

    it "can have 1 or more votes" do
      user = users(:two)
      vote = votes(:vote1)

      user.votes << vote

      expect(user.votes.length).must_equal 1
    end
  end
end
