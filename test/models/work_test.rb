require "test_helper"

describe Work do
  let(:work) {
    works(:book_1)
  }

  let(:user) {
    users(:one)
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

  describe "find most voted" do
    it "should return a work that was voted most" do
      vote = Vote.new(work_id: work.id, user_id: user.id)
      vote.save
      expect(Work.find_most_voted).must_be_instance_of Work
      expect(Work.find_most_voted.id).must_equal work.id
    end
  end

  describe "find top ten books" do
    let(:books) { Work.where(category: "book") }

    it "should return a list of works that belong to book category" do
      expect(Work.find_top_ten("book")).must_be_kind_of Array
    end

    it "should return a list of 10 books" do
      expect(Work.find_top_ten("book").length).must_equal 10
    end

    it "should return a truncated list of books after some being deleted" do
      num_books = books.length

      works(:book_5).destroy
      works(:book_6).destroy

      expect(Work.find_top_ten("book").length).must_equal num_books - 2
    end

    it "should return an empty list if no books exist" do
      books.each do |book|
        book.destroy
      end
      expect(Work.find_top_ten("book")).must_be_empty
    end
  end

  describe "top ten movies" do
    let(:movies) { Work.where(category: "movie") }

    it "should return a list of 10 movies" do
      expect(Work.find_top_ten("movie").length).must_equal 10
    end

    it "should reduce the number of movie after some deletions" do
      num_movies = movies.length

      works(:movie_1).destroy
      works(:movie_2).destroy

      expect(Work.find_top_ten("movie").length).must_equal num_movies - 2
    end

    it "should return an empty list if no movies exist" do
      movies.each do |movie|
        movie.destroy
      end
      expect(Work.find_top_ten("movie")).must_be_empty
    end
  end

  describe "top ten albums" do
    let(:albums) { Work.where(category: "album") }

    it "should return a list of 10 albums" do
      expect(Work.find_top_ten("album").length).must_equal 10
    end

    it "should reduce the number of album after some deletions" do
      num_albums = albums.length

      works(:album_5).destroy
      works(:album_6).destroy

      expect(Work.find_top_ten("album").length).must_equal num_albums - 2
    end

    it "should return an empty list if no album exist" do
      albums.each do |album|
        album.destroy
      end
      expect(Work.find_top_ten("album")).must_be_empty
    end
  end
end
