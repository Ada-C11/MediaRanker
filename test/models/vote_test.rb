require "test_helper"

describe Vote do
  let(:user) { users(:one) }
  let(:work) { works(:album) }
  let(:vote) { votes(:vote3) }

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
    it "belongs to a work and a user" do
      vote.user = user
      vote.work = work

      expect(vote.user_id).must_equal user.id
      expect(vote.work_id).must_equal work.id
    end

    it "can set the work through the work_id and the user through the user_id" do

      # user = users(:no_votes)
      vote.user_id = user.id
      vote.work_id = work.id

      expect(vote.user).must_equal user
      expect(vote.work).must_equal work
    end
  end
end
