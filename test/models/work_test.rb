require "test_helper"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "top_ten" do
    it "must return an array" do
      works = Work.top_ten("album")
      expect(works.length).must_equal 10
    end
  end
end
