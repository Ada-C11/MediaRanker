require "test_helper"

describe Work do
  let(:work) { Work.new }

  describe "Relationships" do
  end

  describe "Validations" do
    it "is valid when all fields are present" do
      expect(work).must_be :valid?
    end

    it "must have a title" do
      work.title = nil
      valid = work.valid?

      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "must have a unique title for the same category" do
      other_work = Work.new title: work.title, category: "book"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal false
      expect(other_work.errors.messages).must_include :title
    end

    it "can have the same title for different categories" do
      other_work = Work.new title: work.title, category: "album"
      other_work.save

      valid = other_work.valid?

      expect(valid).must_equal true
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
  describe "self.get_media_categories" do
    it "returns an array of length 3" do
      media = Work.get_media_categories

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
    it "returns one work even if there is a tie" do
      most_votes = Work.all.max_by { |work| work.votes.count }

      highest_voted = Work.all.select { |a_work| a_work.votes.length == most_votes.votes.count }

      expect(highest_voted.length).must_equal 2
      expect(Work.spotlight).must_be_instance_of Work
    end
  end

  describe "Work.get_media_categories" do
    before do
      @categories = Work.get_media_categories
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
