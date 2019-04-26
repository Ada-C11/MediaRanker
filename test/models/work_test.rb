require "test_helper"

describe Work do
  let(:work) { Work.new(title: "Test Book") }

  it "must be valid" do
    value(work).must_be :valid?
  end
end
