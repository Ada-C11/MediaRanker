require "test_helper"

describe Work do
  describe "validations" do
    it "is valid when all fields are present" do
      result = works(:hp1).valid?

      expect(result).must_equal true
    end

    it "is invalid when title is not present" do
      invalid_work = works(:hp1)
      invalid_work.title = ""

      result = invalid_work.valid?

      expect(result).must_equal false
      expect(invalid_work.errors.messages).must_include :title
    end
  end

  describe "self.top" do
    it "returns object of media" do
      expect(Work.top).must_be_kind_of Work
    end

    it "returns object of media with the most votes" do
      expect(Work.top).must_equal works(:hp4) # based on fixtures
    end

    it "returns nil if no media" do
      Work.all.each do |work|
        work.votes.each { |vote| vote.destroy }
        work.destroy
      end

      expect(Work.top).must_be_nil
    end

    it "returns one object if there's a tie" do
      work = works(:youvegotmail)
      Vote.create(user: users(:dee), work: work)

      expect(work.votes.length).must_equal works(:hp4).votes.length
      expect(Work.top).must_be_kind_of Work
    end
  end

  describe "self.list_by_votes" do
    it "returns an array of work objects" do
      list = Work.list_by_votes("movie")
      expect(list).must_be_kind_of Array
      expect(list.first).must_be_kind_of Work
    end

    it "returns an array of every work objects of that category" do
      list = Work.list_by_votes("movie")
      full_list = Work.where(category: "movie")

      expect(list.length).must_equal full_list.length
    end

    it "returns a sorted array by votes, most to least" do
      list = Work.list_by_votes("album")
      assert list.first.votes.length >= list.last.votes.length
    end

    it "returns an empty array if no media of that type" do
      Work.where(category: "book").each do |book|
        book.votes.each { |vote| vote.destroy }
      end
      Work.where(category: "book").each { |book| book.destroy }

      expect(Work.list_by_votes("book")).must_equal []
    end
  end

  describe "self.top_ten" do
    it "returns an array of objects" do
      top_books = Work.top_ten("book")
      expect(top_books).must_be_kind_of Array
      expect(top_books.first).must_be_kind_of Work
    end

    it "returns an array of ten objects if more than ten of that media type exist" do
      top_books = Work.top_ten("book")
      expect(top_books.length).must_equal 10
    end

    it "returns an array of all objects of type if less than 10 exist" do
      all_movies = Work.where(category: "movie")
      top_movies = Work.top_ten("movie")
      assert top_movies.length < 10 # for sake of test, must be true
      expect(top_movies.length).must_equal all_movies.length
    end

    it "returns an empty array if no media of that type" do
      all_albums = Work.where(category: "album")
      all_albums.each do |album|
        album.votes.each { |vote| vote.destroy }
        album.destroy
      end

      expect(Work.where(category: "album").length).must_equal 0

      top_albums = Work.top_ten("album")
      expect(top_albums).must_be_kind_of Array
      expect(top_albums.length).must_equal 0
      expect(top_albums).must_equal []
    end

    it "returns the 10 objects of given type with most votes" do
      top_books = Work.top_ten("book")

      expect(top_books.include?(works(:book11))).must_equal false # only book fixture with no votes
    end
  end
end
