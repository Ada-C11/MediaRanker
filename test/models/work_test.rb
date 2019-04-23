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
end
