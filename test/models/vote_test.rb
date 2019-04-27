require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }
  let(:user) { users(:user_one) }
  let(:work) { works(:book2) }

  describe "validation" do
    it "must be valid" do
      valid_vote = vote.valid?

      expect(valid_vote).must_equal true
    end

    it "must not let a user vote on the same work more than once" do
      Vote.create(user_id: user.id, work_id: work.id)
      vote_attempt = Vote.new(user_id: user.id, work_id: work.id)

      expect(vote_attempt.valid?).must_equal false
      expect(vote_attempt.errors.messages).must_include :user_id
      expect(vote_attempt.errors.messages[:user_id]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      expect(vote.user_id).must_equal vote.user.id
      expect(vote.user.username).must_equal "obsessed-with-pizza"
    end

    it "belongs to a work" do
      expect(vote.work_id).must_equal vote.work.id
      expect(vote.work.title).must_equal "Grokking Algorithms"
    end
  end
end
