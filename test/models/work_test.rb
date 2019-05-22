require "test_helper"

describe Work do
  describe "validation" do
    before do
      @movie = works(:movie)
    end

    it "must be valid" do
      value(@movie).must_be :valid?
    end

    it "needs a title" do
      @movie.title = nil
      expect(@movie.valid?).must_equal false
      expect(@movie.errors.messages).must_include :title
    end

    it "needs a category" do
      @movie.category = nil
      expect(@movie.valid?).must_equal false
      expect(@movie.errors.messages).must_include :category
    end

    it "needs a creator" do
      @movie.creator = nil
      expect(@movie.valid?).must_equal false
      expect(@movie.errors.messages).must_include :creator
    end
  end

  describe "custom methods" do
    it "finds the work with the most votes" do
      featured = Work.top_work
      # the top work in the fixtures file has 10 votes
      expect(featured.votes_count).must_equal 10
    end

    it "top_ten gets a list of ten works" do
      12.times do |i|
        Work.create!(title: i, category: "movie", creator: "no one", votes_count: i)
      end

      works_array = Work.top_ten("movie")

      expect(works_array.count).must_equal 10
      expect(works_array.first.votes_count).must_equal 11
    end

    it "top_ten gets all the records if there are fewer than 10" do
      works_array = Work.top_ten("movie")

      # there is 1 movie in the fixtures db
      expect(works_array.count).must_equal 1
    end

    it "top_ten returns an empty array if there are no works in the category" do
      works_array = Work.top_ten("album")

      # there are no albums in the fixtures db

      expect(works_array.count).must_equal 0
    end
  end
end
