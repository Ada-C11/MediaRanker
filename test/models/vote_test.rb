require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_a) }

  it "must be valid" do
    expect(vote.valid?).must_equal true
  end

  it "must require a user_id" do
    vote_fail = votes(:vote_x)

    expect(vote_fail.valid?).must_equal false
    # expect(vote_fail.errors.messages).must_include "must exist"
    # why doesn't this work?
  end

  describe "relationships" do
    it "can have many votes" do
      user = users(:one)
      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
