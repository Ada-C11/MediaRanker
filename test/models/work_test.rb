require "test_helper"
require "pry"

describe Work do
  let(:work) { Work.new }
  let(:gump) { works(:gump) }
  let(:tree) { works(:tree) }
  let(:user_one) { users(:one) }
  let(:user_two) { users(:two) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  describe "relations" do
    it "has votes" do
      expect(tree.votes.count).must_equal 2
      expect(tree.votes.include?(votes(:one))).must_equal true
    end

    it "can access users who have its votes" do
      expect(tree.users.count).must_equal 2
      expect(tree.users.include?(user_one)).must_equal true
    end
  end

  describe "categories" do
    it "must return a list of categories" do
      categories = Work.categories

      expect(categories).must_include("album")
      expect(categories).must_include("book")
      expect(categories).must_include("movie")
    end
  end

  describe "highlight" do
    it "returns the work with the most votes" do
      Vote.create!(work: tree, user: user_one)
      Vote.create!(work: gump, user: user_two)

      highlight = Work.highlight

      expect(highlight.title).must_equal "A Tree Grows in Brooklyn"
    end

    it "returns the first work if vote counts are equal" do
      Vote.create!(work: gump, user: user_one)
      Vote.create!(work: gump, user: user_two)
      first = Work.first
      highlight = Work.highlight

      expect(highlight).must_equal first
    end
  end

  describe "top_works" do
    it "returns a list of the top 10 works in a category" do
      book_titles = ["hp01", "hp02", "hp03", "hp04", "hp05", "hp06", "hp07", "hp08", "hp09", "hp10"]

      book_titles.each do |title|
        harry = Work.create!(category: "book", title: title, creator: "JK Rowling", pub_year: 2001, description: "You're a wizard")
        Vote.create!(work: harry, user: user_one)
      end

      Vote.create!(work: Work.find_by(title: "hp02"), user: user_two)

      top_books = Work.top_works("book")
      top_book_titles = top_books.map do |book|
        book.title
      end

      expect(top_book_titles.first).must_equal "hp02"
      expect(top_book_titles.sort).must_equal book_titles
    end

    it "returns a list of less than 10 works if there are less than 10 works" do
      book_titles = ["hp01", "hp02", "hp03", "hp04"]

      book_titles.each do |title|
        harry = Work.create!(category: "book", title: title, creator: "JK Rowling", pub_year: 2001, description: "You're a wizard")
        Vote.create!(work: harry, user: user_one)
      end

      top_books = Work.top_works("book")
      expect(top_books.count).must_equal 4
    end

    it "returns an empty array if there are no works in that category" do
      top_cars = Work.top_works("car")

      expect(top_cars).must_equal []
    end
  end

  describe "vote_count" do
    it "returns a work's vote count" do
      Vote.create!(work: gump, user: user_one)

      expect(gump.vote_count).must_equal 1
    end
  end

  describe "category_all" do
    it "can return all the works in a category" do
      expect(Work.category_all("movie").count).must_equal 1
    end

    it "returns an empty array if there are no works in that category" do
      top_cars = Work.category_all("car")

      expect(top_cars).must_equal []
    end
  end

  describe "created_date" do
    it "must return a formatted string of the date" do
      work.save

      expect(work.created_date).must_equal "#{work.created_at.strftime("%B %d, %Y")}"
    end
  end
end
