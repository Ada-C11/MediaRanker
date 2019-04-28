require "test_helper"

describe Work do
  # let(:work) { Work.new }
  before do
    @work = Work.new(
      title: "some unique test title",
    )
  end
  describe "validations" do
    it "passes validations with good data" do
      expect(@work).must_be :valid?
    end

    it "rejects work with the same title" do
      # arrange
      duplicate_title = Work.first.title
      @work.title = duplicate_title

      # act
      result = @work.valid?

      # assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end
  describe "relations" do
    it "has votes" do
      work = works(:a)
      expect(work.votes.length).must_equal 3
    end
  end

  describe "spotligth" do
    it "will return the work with most votes" do
      work1 = works(:a)
      spot = Work.spotlight
      expect(spot).must_equal work1
    end
  end
  describe "top ten movies" do
    it "will return an empty arrayif there are no movies" do
      movies = Work.top_ten_movies

      expect(movies).must_equal []
    end
  end
  describe "top ten books" do
    it "will return 10 books in ascending order" do
      books = Work.top_ten_books
      book1 = works(:a)
      book2 = works(:c)

      expect(books.length).must_equal 10
      expect(books.first).must_equal book1
      expect(books.second).must_equal book2
    end
  end
  describe "top ten album" do
    it "will return all the albums if there are less than 10" do
      albums = Work.top_ten_albums

      expect(albums.length).must_equal 2
    end
  end
end
