require "test_helper"

describe Upvote do
  let(:upvote) { Upvote.new }

  it "must be valid" do
    value(upvote).must_be :valid?
  end
end
