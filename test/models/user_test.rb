require "test_helper"

describe User do
  let(:user) { users(:user_one) }
  let(:work) { works(:movie2) }

  describe "validations" do
    it "must be valid" do
      valid_user = user.valid?

      expect(valid_user).must_equal true
    end

    it "requires a username" do
      user.username = nil

      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      new_vote = Vote.create(work_id: work.id, user_id: user.id)

      expect(user.votes).must_include new_vote
      expect(user.votes.count).must_equal 3
    end

    it "can have many works through votes" do
      new_vote = Vote.create(work_id: work.id, user_id: user.id)

      expect(user.works).must_include work
      expect(user.works.count).must_equal 3
    end
  end
end
