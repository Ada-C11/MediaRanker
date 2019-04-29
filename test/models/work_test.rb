require "test_helper"

describe Work do
  let(:work) { works(:three_w) }

  it "must be valid" do
    value(work).must_be :valid?
  end
end
