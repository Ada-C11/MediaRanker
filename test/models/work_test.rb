require "test_helper"

describe Work do
  let(:work) { Work.new }
  describe "Validations" do
    it "Validates with good data" do
      work.title = "A new Hope"

      result = work.valid?

      expect(result).must_equal true
    end

    it "Wont validate a work without a title" do
      result = work.valid?

      expect(result).must_equal false
    end
  end

  describe "Relationships" do
    it "can add a vote through votes" do
      vote = votes.first
      work.votes << vote

      expect(work.votes).must_include vote
      expect(vote.work_id).must_equal work.id
    end
  end

  describe "self.get_media_catagories" do
    it "returns an array of length 3" do
      media = Work.get_media_catagories

      expect(media).must_be_instance_of Array

      expect(media.length).must_equal 3
    end
  end

  describe "self.top_media" do
    it "gets 10 works for categories with more than 10 works" do
      11.times do
        new_work = Work.new
        new_work.category = "book"
        new_work.title = "new book"
        new_work.save
      end

      expect(Work.top_media.first.length).must_equal 10
    end

    it "returns less than 10 works if there are less than 10 works" do
      categories = Work.top_media

      categories.map! { |category| category.length }

      expect(categories).must_equal [2, 1, 1]
    end
  end
  describe "Work.get_media" do
    it "returns an empty array if there are no works" do
      Work.all.each { |a_work| a_work.destroy }

      expect(Work.get_media("book")).must_equal []
    end
    it "returns works from the proper category" do
      books = Work.get_media("book")

      expect(books.first.category).must_equal "book"
    end
  end
  describe "self.spotlight" do
    it "returns a Work" do
      spotlight = Work.spotlight

      expect(spotlight).must_be_instance_of Work
    end
    it "returns nil if there are no works" do
      Work.all.each { |a_work| a_work.destroy }

      expect(Work.spotlight).must_equal nil
    end
    it "returns the work with the most votes" do
      spotlight = Work.spotlight
      max_votes = Work.all.max_by { |a_work| a_work.votes.count }
      expect(spotlight).must_equal max_votes
    end
  end

  describe "Work.get_media_categories" do
    before do
      @categories = Work.get_media_catagories
    end
    it "returns an array of arrays" do
      expect(@categories).must_be_instance_of Array
      expect(@categories.first).must_be_instance_of Array
      expect(@categories.last).must_be_instance_of Array
    end
    it "has a three categories of correct type" do
      expect(@categories.length).must_equal 3
      expect(@categories[0].first.category).must_equal "book"
      expect(@categories[1].first.category).must_equal "album"
      expect(@categories[2].first.category).must_equal "movie"
    end
  end
end
