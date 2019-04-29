require "test_helper"

describe User do
  let(:user) { User.new }
  let (:user_valid) { users(:custom1) }
  describe "validations" do
    it "rejects validations with bad data" do
      expect(user.valid?).must_equal false
      expect(user.errors.messages[:username][0]).must_equal "can't be blank"
    end

    it "passes validations with good data" do
      expect(user_valid).must_be :valid?
    end
  end

  describe "#user" do
    it "finds the user associated with a user id" do
      expect(User.user(user_valid.id)).must_equal user_valid
    end

    it "returns nil if user doesnt exist" do
      expect(User.user(-1)).must_be_nil
    end
  end

  describe "#vote_count" do
    it "returns the number of votes taken by a given user" do
      User.vote_count(user_valid).must_equal 2
    end
  end
end
