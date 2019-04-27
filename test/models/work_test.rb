require "test_helper"

describe Work do
  let(:work) { 
    works(:uprooted)
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
      work.category = "album"

      # Act
      work_category = work.valid?

      # Assert
      expect(work_category).must_equal true
    end

    it "will show an error if work has no category" do
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

  describe "relationshps" do
    it "has many votes" do
      expect(work).must_respond_to :votes
    end
  end

  describe "custom method sort_by_category" do 
    it "will return an array" do
      books = Work.sort_by_category("book") 

      expect(books).must_be_kind_of Array

      random_book = books.sample

      expect(random_book).must_be_kind_of Work
      expect(random_book.category).must_equal "book"
    end
  end

  describe "custom method popular" do  
    it "is sorted so the first book has more votes than last" do
      vote = Vote.new(user_id: users(:jane), work_id: works(:therook))

      book_with_vote = Work.popular.first
      expect(book_with_vote).must_equal works(:therook)
    end
  end

  describe "custom method media_spotlight " do
    it "will return the spotlight title" do

      vote1 = Vote.new(user_id: users(:jane), work_id: works(:therook))
      vote2 = Vote.new(user_id: users(:john), work_id: works(:thehungergames))
      vote3 = Vote.new(user_id: users(:faiza), work_id: works(:therook))
      vote4 = Vote.new(user_id: users(:ahsan), work_id: works(:therook))
  
      spotlight = Work.media_spotlight

      expect(spotlight.title).must_equal "The Rook"
    end
  end

  describe "custom method top_10" do
     it "sorts works in descending order by votes" do

      vote1 = Vote.new(user_id: users(:jane), work_id: works(:therook))
      vote2 = Vote.new(user_id: users(:john), work_id: works(:thehungergames))
      vote3 = Vote.new(user_id: users(:faiza), work_id: works(:therook))
      vote4 = Vote.new(user_id: users(:ahsan), work_id: works(:therook))

      sorted = Work.top_10("book")
      first = sorted.first.votes.count
      last = sorted.last.votes.count

      expect(first).must_be :>=, last
    end

    it "displays 10 works" do
      sorted = Work.top_10("book")
       expect(sorted.length).must_be :<=, 10
    end
  end




end # outermost describe
