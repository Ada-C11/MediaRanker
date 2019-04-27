require "test_helper"

describe Work do
  let(:work) { Work.new }
  let(:monkey) { works(:monkey) }
  describe "validations" do
    it "rejects validations with bad data" do
      work
      expect(work.valid?).must_equal false
      expect(work.errors.messages[:title][0]).must_equal "can't be blank"
      expect(work.errors.messages[:category][0]).must_equal "can't be blank"
    end

    it "passes validations with good data" do
      work = works(:custom1)
      expect(work).must_be :valid?
    end
  end

  describe "relations" do
    it "has votes" do
      work = monkey
      expect(work.votes).wont_be_nil
    end

    it "has users through votes" do
      work = monkey
      expect(work.users).wont_be_nil
    end
  end

  describe "media_votes" do
    it "returns a list of works in ascending order of vote counts" do
      list_all_movies = Work.media_votes("movie")
      expect(list_all_movies[0]).must_equal monkey
      expect(list_all_movies[1]).must_equal works(:avengers)
      expect(list_all_movies[2]).must_equal works(:random8)
    end

    it "returns an empty array if category doesnt exist" do
      list_all_movies = Work.media_votes("show")
      expect(list_all_movies).must_equal []
    end

    it "returns an empty array if no works associated with that category" do
      list_all_movies = Work.media_votes("album")
      expect(list_all_movies).must_equal []
    end
  end

  describe "#top_ten_media_votes" do
    it "returns only ten media if there are ten or more media in that category" do
      list_all_movies = Work.top_ten_media_votes("movie")
      expect(list_all_movies.length).must_equal 10
    end

    it "return less than ten media if the total works for a given category is less than ten" do
      list_all_movies = Work.top_ten_media_votes("book")
      expect(list_all_movies.length).must_be :<, 10
    end
  end

  describe "media_vote_count" do
    it "returns number of votes for a given work" do
      work = monkey
      expect(Work.media_vote_count(work)).must_equal 3
    end
  end
end
