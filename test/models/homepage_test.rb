require "test_helper"

describe Homepage do
  let(:homepage) { Homepage.new }

  it "must be valid" do
    value(homepage).must_be :valid?
  end
end
