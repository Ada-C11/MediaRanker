require "test_helper"

describe Work do
  require "test_helper"

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

  # describe "relations" do
  #   it 'can set the author through "author"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")

  #     # Make the models relate to one another
  #     book.author = author

  #     # author_id should have changed accordingly
  #     expect(book.author_id).must_equal author.id
  #   end

  #   it 'can set the author through "author_id"' do
  #     # Create two models
  #     author = Author.create!(name: "test author")
  #     book = Book.new(title: "test book")

  #     # Make the models relate to one another
  #     book.author_id = author.id

  #     # author should have changed accordingly
  #     expect(book.author).must_equal author
  #   end
  # end

  describe "self.top" do
    it "returns object of media" do
      expect(Work.top).must_be_kind_of Work
    end

    it "returns object of media with the most votes" do
    end

    it "returns nil if no media" do
      Work.all.each { |work| work.destroy }
      expect(Work.top).must_be_nil
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
      all_albums.each { |album| album.destroy }

      expect(Work.where(category: "album").length).must_equal 0

      top_albums = Work.top_ten("album")
      expect(top_albums).must_be_kind_of Array
      expect(top_albums.length).must_equal 0
      expect(top_albums).must_equal []
    end

    it "returns the 10 objects of given type with most votes" do
    end
  end
end
