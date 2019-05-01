require "test_helper"

describe Work do
  let(:album1) { works(:album1) }
  let(:user) { users(:one) }
  let(:vote1) { votes(:vote1) }
  let(:vote2) { votes(:vote2) }

  it "must be valid" do
    value(album1).must_be :valid?
  end
end
