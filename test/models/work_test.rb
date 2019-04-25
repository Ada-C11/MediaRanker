require "test_helper"

describe Work do
  let(:work) { 
    works(:one)
  }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "validation" do 
    it "work must have a title" do 
      # Arrange
      work.title = ""

      # Act
      valid_work = work.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      # Arrange
      duplicate_work = Work.new( title: work.title )

      # Act - Assert
      expect(duplicate_work.save).must_equal false

      # Assert
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "work must have a category" do
      # Arrange
      work.category = ""

      # Act
      work_category = work.valid?

      # Assert
      expect(work_category).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end
  end
end # outermost describe
