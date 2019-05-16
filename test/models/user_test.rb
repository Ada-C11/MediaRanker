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
    it "has a list of votes" do
      user.must_respond_to :votes
      user.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of voted on works" do
      user.must_respond_to :works
      user.works.each do |work|
        work.must_be_kind_of Work
      end
    end
  end
end
