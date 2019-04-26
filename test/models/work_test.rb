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

  describe "sort_work model method" do
    it "sorts work of a certain category by votes" do
      # Act-Assert
      expect(Work.sort_work("album").first).must_equal works(:work_ten)
    end
  end

  describe "highest_vote model method" do
    it "spotligts the work with the most votes" do
      # Act-Assert
      expect(Work.highest_vote).must_equal works(:work_ten)
    end

    it "spotlights a work even if no works have votes" do
      # Arrange
      Vote.delete_all

      # Act-Assert
      expect(Work.highest_vote).wont_be_nil
    end

    it "will spotlight one work if there is a tie for most votes" do
      # Arrange
      Vote.delete_all

      vote = Vote.new(user_id: users(:user_one), work_id: works(:work_one))
      vote2 = Vote.new(user_id: users(:user_two), work_id: works(:work_two))

      # Act-Assert
      expect(Work.highest_vote).must_equal works(:work_one) || works(:work_two)
    end
  end

  describe "top_ten model method" do
    it "shows ten works of a certain type with the most votes" do
      # Act-Assert
      expect(Work.top_ten("album").first).must_equal works(:work_ten)
    end

    it "shows 10 works even when there are less than 10 works with votes" do
      expect(Work.top_ten("album").length).must_equal 10
    end
  end
end
