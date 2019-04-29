require "test_helper"

describe Work do
  let(:album) { works(:album) }

  it "must be valid" do
    expect(album.valid?).must_equal true
  end

  describe "validations" do
    it "requires a category" do
      album.category = nil

      valid_work = album.valid?

      expect(valid_work).must_equal false
      expect(album.errors.messages).must_include :category
      expect(album.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      duplicate_album = Work.new(category: album.category, title: album.title)

      expect(duplicate_album.save).must_equal false

      expect(duplicate_album.errors.messages).must_include :title
      expect(duplicate_album.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "can have 0 votes" do
      work = works(:book)

      expect(work.votes.length).must_equal 0
    end

    it "can have 1 or more votes" do
      work = works(:album)

      expect(work.votes.length).must_equal 1
    end
  end

  describe "self.top_ten method" do
    it "must return the top ten works, based on votes" do
      top_array = Work.top_ten("album")

      expect(top_array.length).must_equal 10
      expect(top_array[0][:title]).must_equal "Test Album4"
    end

    it "will return few works if there are not at least 10 in a category" do
      top_array = Work.top_ten("book")

      expect(top_array.length).must_equal 2
    end

    it "will return an empty array if there are no works in the category" do
      top_array = Work.top_ten("movie")

      expect(top_array).must_equal []
    end
  end

  describe "media_spotlight method" do
    it "must return the work with the most votes" do
      top_work = Work.media_spotlight

      expect(top_work.title).must_equal "Book Test2"
    end
  end
end
