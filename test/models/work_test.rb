require "test_helper"

describe Work do
  let(:work) { works(:spaghetti) }
  let(:kim) { users(:kim) }
  let(:aj) { users(:aj) }
  let(:harry) { works(:harry_six) }
  let(:harry2) { works(:harry_two) }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  describe "validations" do
    it "must have a category" do
      work.category = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false

      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      work.title = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      duplicate_work = Work.new(category: "book", title: "War and Peace", creator: "Michael Jackson")

      expect(duplicate_work.save).must_equal false

      expect(duplicate_work.errors.messages).must_include :title
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "must have a creator" do
      work.creator = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages[:creator]).must_equal ["can't be blank"]
    end
  end

  describe "relations" do
    # has many votes
    # has many users through votes
    it "has a list of votes" do
      work.must_respond_to :votes
      work.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of voting users" do
      work.must_respond_to :users
      work.users.each do |user|
        user.must_be_kind_of User
      end
    end
  end

  describe "top_ten" do
    it "returns a list of media for the correct category" do
      books = Work.top_ten("book")
      books.length.must_equal 8
      books.each do |book|
        book.must_be_kind_of Work
        book.category.must_equal "book"
      end
    end

    it "orders media by highest vote count" do
      aj.works << harry
      kim.works << harry

      albums = Work.top_ten("album")

      expect(albums.length).must_equal 3
      expect(albums.first.title).must_equal harry.title
      expect(albums.first.votes.length).must_equal 2
      # voted for in fixtures
      expect(albums[1]).must_equal work
      expect(albums[1].votes.length).must_equal 1
    end

    it "returns at most 10 items" do
      albums = Work.top_ten("book")
      albums.length.must_equal 8

      Work.create(title: "Testing 123", category: "book", creator: "Testing Guy")
      Work.top_ten("book").length.must_equal 9

      Work.create(title: "Testing 1234", category: "book", creator: "Testing Guy")
      Work.top_ten("book").length.must_equal 10

      Work.create(title: "Testing 12345", category: "book", creator: "Testing Guy")
      Work.top_ten("book").length.must_equal 10
    end
  end

  describe "top_voted" do
    it "returns a list of media" do
      books = Work.top_voted("book")
      books.length.must_equal 8
      books.each do |book|
        book.must_be_kind_of Work
        book.category.must_equal "book"
      end
    end

    it "orders media by highest vote count" do
      aj.works << harry
      kim.works << harry

      albums = Work.top_voted("album")

      expect(albums.length).must_equal 3
      expect(albums.first.title).must_equal harry.title
      expect(albums.first.votes.length).must_equal 2
      # voted for in fixtures
      expect(albums[1]).must_equal work
      expect(albums[1].votes.length).must_equal 1
    end

    it "returns more than 10 items if more than 10 items exist" do
      albums = Work.top_voted("book")
      albums.length.must_equal 8

      Work.create(title: "Testing 123", category: "book", creator: "Testing Guy")
      Work.top_voted("book").length.must_equal 9

      Work.create(title: "Testing 1234", category: "book", creator: "Testing Guy")
      Work.top_voted("book").length.must_equal 10

      Work.create(title: "Testing 12345", category: "book", creator: "Testing Guy")
      Work.top_voted("book").length.must_equal 11
    end
  end

  describe "spotlight" do
    it "must return the top voted work across all categories" do
      expect(Work.spotlight).must_equal work
      expect(Work.spotlight.category).must_equal "album"
      expect(Work.spotlight.votes.length).must_equal 1

      aj.works << harry2
      kim.works << harry2

      expect(Work.spotlight).must_equal harry2
      expect(Work.spotlight.category).must_equal "book"
      expect(Work.spotlight.votes.length).must_equal 2
    end
  end
end
