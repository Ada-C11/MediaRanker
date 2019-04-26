require "test_helper"

describe Work do
  let (:work) {
    works(:book_1)
  }

  it "must be valid" do
    valid_work = work.valid?

    expect(valid_work).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      # Arrange
      work.title = nil

      # Act
      valid_work = work.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      # Arrange
      duplicate_work = Work.new(title: work.title, category: work.category, creator: work.creator, publication_year: work.publication_year, description: work.description)

      # Act-Assert
      expect(duplicate_work.save).must_equal false

      # Assert
      expect(duplicate_work.errors.messages).must_include :title
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end
end
