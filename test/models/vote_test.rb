require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }

  describe "validation" do
    it "must be valid" do
      valid_vote = vote.valid?

      expect(valid_vote).must_equal true
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
