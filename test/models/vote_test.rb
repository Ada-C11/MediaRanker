require "test_helper"

describe Vote do
  let(:vote) { votes(:one) }

  it "must be valid" do
    expect(vote.valid?).must_equal true
  end

  describe "validations" do
    it "will not be valid without user" do
      vote.user = nil
      expect(vote.valid?).must_equal false
    end

    it "will not be valid with out works" do
      vote.work = nil
      expect(vote.valid?).must_equal false
    end

    it "will not be valid when another vote has same user and same works " do
      new_vote = Vote.new(user_id: vote.user.id, work_id: vote.work.id)
      expect(new_vote.save).must_equal false
    end

    # will do this in controller create action for vote.
    it "will be valid when only user OR works is repeated" do
      new_vote = Vote.new(user: users(:two), work: vote.work)
      expect(new_vote.save).must_equal true
    end
  end
  describe "relationships" do
    it "will have one user" do
      expect(vote.user).must_equal users(:one)
    end

    it "will have one vote" do
      expect(vote.work).must_equal works(:one)
    end
  end
end
