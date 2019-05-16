require "test_helper"

describe Vote do
  let(:vote) { votes(:one) }

  it "must be valid" do
    value(vote).must_be :valid?
  end
end
