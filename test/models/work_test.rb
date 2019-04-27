require "test_helper"
require "pry"

# For top-10 or spotlight, what if there are less than 10 works?
# What if there are no works?

describe Work do
  let(:work) { Work.first }

  describe "validation" do
    it "has valid data" do
      expect(work).must_be :valid?
    end

    it "requires a present title" do
      invalid_work = Work.new
      invalid_work.save
      error_message = invalid_work.errors.messages[:title][0]
      expect(invalid_work.valid?).must_equal false
      expect(error_message).must_equal "can't be blank"
    end

    it "responds to votes" do
      assert_respond_to(work, :votes)
    end

    it "rejects a duplicate title" do
      title = work.title
      invalid_work = Work.new(title: title)
      invalid_work.save
      error_message = invalid_work.errors.messages[:title][0]
      expect(invalid_work.valid?).must_equal false
      expect(error_message).must_equal "has already been taken"
    end
  end

  describe "custom methods" do
    describe "media category methods" do
      it "returns an array of albums" do
        albums = Work.albums
        albums.each do |album|
          expect(album.category).must_equal "album"
        end
        expect(albums.count).must_equal Work.where(category: "album").count
      end

      it "returns an array of movies" do
        movies = Work.movies
        movies.each do |movie|
          expect(movie.category).must_equal "movie"
        end
        expect(movies.count).must_equal Work.where(category: "movie").count
      end

      it "returns an array of books" do
        books = Work.books
        books.each do |book|
          expect(book.category).must_equal "book"
        end
        expect(books.count).must_equal Work.where(category: "book").count
      end

      it "returns an empty array when there are no works" do
        Work.destroy_all
        expect(Work.albums).must_equal []
        expect(Work.movies).must_equal []
        expect(Work.albums).must_equal []
      end
    end
    describe "spotlight" do
      it "displays a spotlighted work" do
        spotlight_work = Work.spotlight
        expect(spotlight_work).must_be_instance_of Work
      end

      it "returns nil for no works" do
        Work.destroy_all
        expect(Work.spotlight).must_equal nil
      end
    end

    describe "top ten" do
    end
  end
end
