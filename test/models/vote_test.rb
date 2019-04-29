require "test_helper"

describe Vote do
  let(:user) { users(:one) }
  let(:work) { works(:album) }
  let(:vote) { votes(:vote1) }

  it "must be valid" do
    expect(vote.valid?).must_equal true
  end

  describe "validations" do
    it "requires a user_id and work_id" do
      vote.user = nil
      expect(vote.valid?).must_equal false

      vote.user = user
      expect(vote.valid?).must_equal true

      vote.work = nil
      expect(vote.valid?).must_equal false

      vote.work = work
      expect(vote.valid?).must_equal true
    end

    it "allows only 1 vote per user for a specific work" do
      first_vote = Vote.new
      first_vote.user = user
      first_vote.work = work

      expect(first_vote.save).must_equal true

      second_vote = Vote.new
      second_vote.user = user
      second_vote.work = work

      expect(second_vote.save).must_equal false
    end
  end

  describe "relationships" do
  end
end
