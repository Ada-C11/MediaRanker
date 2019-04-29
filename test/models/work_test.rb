require "test_helper"
require "pry"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "top_ten" do
    it "must return an array of 10" do
      works = Work.top_ten("album")
      expect(works.length).must_equal 10
      expect(works).must_be_kind_of Array
    end

    it "must return an empty array if no works" do
      works = Work.top_ten("book")
      expect(works).must_equal []
    end
  end
end
