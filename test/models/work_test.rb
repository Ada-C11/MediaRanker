require "test_helper"

describe Work do
  let(:work) { Work.new(title: "some title", category: "album") }

  it "must be valid" do
    value(work).must_be :valid?
  end
  
end
