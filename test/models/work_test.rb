require "test_helper"

describe Work do
  let(:work) {
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

  describe "relationship" do
    it "can have no vote" do
      expect(work.votes.length).must_equal 0
    end

    it "can have one or more votes" do
      new_vote = Vote.new(user_id: users(:one).id, work_id: work.id)
      new_vote.save

      another_vote = Vote.new(user_id: users(:two).id, work_id: work.id)
      another_vote.save

      expect(work.votes.length).must_equal 2
    end
  end
end
