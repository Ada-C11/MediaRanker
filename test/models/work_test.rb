require "test_helper"

describe Work do
  let(:work) { works(:work_one) }

  it "must be valid" do
    work = works(:work_one)

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

    it "requires a category" do
      # Arrange
      work.category = nil

      # Act
      valid_work = work.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank", "is not included in the list"]
    end

    it "category must be music, album, or book" do
      # Arrange
      work.category = "invalid category"

      # Act
      valid_work = work.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["is not included in the list"]
    end
  end
end
