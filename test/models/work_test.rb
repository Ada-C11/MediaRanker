require "test_helper"

describe Work do
  let(:work) { works(:spaghetti) }
  let(:kim) { users(:kim) }
  let(:aj) { users(:aj) }
  let(:harry) { works(:harry_six) }

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
      aj.works.push(work, harry)
      kim.works << work

      albums = Work.top_ten("album")

      expect(albums.length).must_equal 3
      expect(albums.first.title).must_equal work.title
      # one vote in a my votes fixture, two in this test
      expect(albums.first.votes.length).must_equal 3
      # second most voted for
      expect(albums[1]).must_equal harry
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
  end

  describe "spotlight" do
    it "must return the most voted on work" do
    end

    it "must return nil if no works" do
    end
  end
end
