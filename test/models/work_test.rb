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

  describe "relations" do
    it "has votes" do
      work = works(:return)
      work.votes.must_include votes(:one)
    end

    it "can add votes" do
      work = Work.new(title: "newwork", creator: "newauthor", category: "book")
      vote = Vote.new(user_id: User.last.id, work_id: work.id)
      work.votes << vote
      work.votes.must_include vote
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
    it "returns the works in the category with the most votes" do
      10.times do
        Work.create(title: "test book", creator: "author", category: "book")
      end

      books = Work.where(category: "book")
      max_vote_counts = books.map { |book| book.votes.count }.sort.reverse.first(10)
      top_ten_vote_counts = Work.top_ten("book").map { |book| book.votes.count }
      expect(max_vote_counts).must_equal top_ten_vote_counts
    end
  end
  describe "spotlight" do
    it "returns the work with the maximum number of votes" do
      work_with_max_votes = Work.all.max_by { |work| work.votes.count }
      expect(Work.spotlight).must_equal work_with_max_votes
    end
    it "will return the first work found in the event of a tie" do
      Vote.destroy_all
      10.times do |user|
        user = User.create(username: "#{user}")
        Vote.create(work_id: Work.first.id, user_id: user.id)
        Vote.create(work_id: Work.last.id, user_id: user.id)
      end

      expect(Work.spotlight).must_equal Work.first
    end
  end
end
