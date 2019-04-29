require "test_helper"

describe HomepagesController do
  describe "spotlight" do
    it "returns the work with the most votes" do
      top_work = works(:monkey)
      expect(Homepage.spotlight.title).must_equal top_work.title
      expect(Homepage.spotlight.vote_count).must_equal 3
    end

    it "returns the first work if two works are tied" do
      votes(:custom5).destroy
      expect(Homepage.spotlight.vote_count).must_equal 2
      expect(Homepage.spotlight.title).must_equal "12 Monkeys"
    end
  end
end
