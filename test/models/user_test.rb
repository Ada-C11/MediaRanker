require "test_helper"

describe User do
  let(:user) { users(:one) }
  let(:vote_one) { votes(:one) }
  let(:vote_two) { votes(:two) }
  let(:vote_three) { votes(:two) }

  it "must be valid" do
    value(user.valid?).must_equal true
  end

  describe "validations" do
    it "requires a username" do
      user.username = nil
      valid_user = user.valid?
      expect(valid_user).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      user.votes << vote_one
      user.votes << vote_two
      expect(user.votes.first).must_equal vote_one
      expect(user.votes.last).must_equal vote_two
    end
    it "can have 0 votes" do
      expect(user.votes.length).must_equal 0
    end
  end

  describe "custom methods" do
    describe "vote_counter" do
      it "returns the correct number of votes" do
        user.votes << vote_one
        user.votes << vote_two
        expect(user.vote_counter).must_equal 2

        user.votes << vote_three
        expect(user.vote_counter).must_equal 3
      end

      it "returns 0 when no votes have been made" do
        expect(user.vote_counter).must_equal 0
      end
    end
  end
end
