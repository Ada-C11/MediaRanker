require "test_helper"
require "pry"

describe Work do
  let(:work) { Work.new }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "top_ten" do
    it "must return an array of 10 and be an instance of Work class" do
      works = Work.top_ten("album")
      expect(works.length).must_equal 10
      expect(works).must_be_kind_of Array
      expect(works.first).must_be_kind_of Work
    end

    it "must return all of the works if less than 10 for top ten" do
      works = Work.top_ten("book")
      expect(works.length).must_equal 2
    end

    it "must return an empty array if no works" do
      works = Work.top_ten("movie")
      expect(works).must_equal []
    end
  end

  describe "spotlight" do
    it "must return an instance of Work" do
      spotlight = Work.spotlight
      expect(spotlight).must_be_kind_of Work
    end
  end
end
