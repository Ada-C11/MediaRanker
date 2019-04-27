require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_one) }

  it "must be valid" do
    valid_vote = vote.valid?

    expect(valid_vote).must_equal true
  end
end
