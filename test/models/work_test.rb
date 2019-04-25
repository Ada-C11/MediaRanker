require "test_helper"

describe Work do
  describe "validations" do
    before do
      @work = Work.new(title: "test book", creator: "author", category: "book")
    end

    it "is valid when all fields are present" do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "is invalid without a title" do
      # Arrange
      @work.title = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a creator" do
      # Arrange
      @work.creator = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid without a category" do
      # Arrange
      @work.category = nil

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
    end

    it "is invalid if the category isn't book, movie, or album" do
      # Arrange
      @work.category = "tv series"

      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal false
    end
  end

  describe "top_ten" do
    it "generates a list of 10 works of the given category" do
      # Arrange
      10.times do
        Work.create(title: "test book", creator: "author", category: "book")
      end

      # Act
      top_ten_books = Work.top_ten("book")

      # Assert
      expect(top_ten_books.length).must_equal 10
    end

    it "generates a list of all works if there are less than 10 works in the category" do
      # Act
      top_ten_books = Work.top_ten("book")

      # Assert
      expect(top_ten_books).wont_be_empty
    end

    it "returns an empty array when there are no works in the category" do
      # Arrange
      Work.destroy_all

      # Act
      top_ten_books = Work.top_ten("book")

      # Assert
      expect(top_ten_books.length).must_equal 0
    end
  end
end
