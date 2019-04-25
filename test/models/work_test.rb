require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "Relationships" do
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(work).must_be :valid?
    end

    it "must have a title" do
      work.title = nil
      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "must have a unique title for the same category" do
      other_work = Work.new title: work.title, category: "book"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it "can have the same title for different categories" do
      other_work = Work.new title: work.title, category: "album"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal true
    end
  end

  describe "Custom Methods" do
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
