require "test_helper"

describe Medium do
  let(:medium) { Medium.new }

  it "must be valid" do
    value(medium).must_be :valid?
  end
end
