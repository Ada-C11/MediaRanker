require "test_helper"

describe Work do
  let(:work) { works(:two) }

  it "must be valid" do
    value(work).must_be :valid?
  end

  it "has required fields" do
    fields = [:category, :title, :creator, :publication_year, :description, :votes]

    fields.each do |field|
      expect(work).must_respond_to field
    end
  end

  describe "relationships" do
    it "has many votes" do
      work = works(:three)
      votes = work.votes
      votes << Vote.new(user: users(:three), work: work, date: Date.today)
      votes << Vote.new(user: users(:two), work: work, date: Date.today)

      expect(work).must_be_instance_of Work
      expect(votes).kind_of? Array
      expect(votes.length).must_equal 2
      expect(votes.first).must_be_instance_of Vote
    end

    it "can have 0 votes" do
      work = works(:three)
      votes = work.votes
      expect(work).must_be_instance_of Work
      expect(votes.length).must_equal 0
      expect(work.valid?).must_equal true
    end

    it "has many users through votes" do
      work = works(:one)
      votes = work.votes
      expect(work).must_be_instance_of Work
      expect(votes.length).must_be :>=, 1
      votes.each do |vote|
        expect(vote.user).must_be_instance_of User
      end
    end
  end

  describe "validations" do
    it "must have a category" do
      work.category = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]

      work.category = "book"
      valid = work.valid?
      expect(valid).must_equal true
    end

    it "must have a title" do
      work.title = nil
      valid = work.valid?
      expect(valid).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]

      work.title = "Sabriel"
      valid = work.valid?
      expect(valid).must_equal true
    end

    it "requires a unique title within a category" do
      invalid_work = Work.new title: work.title, category: "book"
      valid = invalid_work.valid?
      expect(valid).must_equal false
      expect(invalid_work.errors.messages).must_include :title
      expect(invalid_work.errors.messages[:title]).must_equal ["has already been taken"]
    end

    it "can have the same title as a work in a different category" do
      work = works(:two)
      valid_work = Work.new title: work.title, category: "movie"
      valid = valid_work.valid?
      expect(valid).must_equal true
    end
  end

  describe "spotlight" do
    it "returns a work object" do
      work = Work.spotlight
      expect(work).must_be_instance_of Work
    end

    it "returns work object with most votes" do
      top_voted = Work.spotlight
      vote_count = top_voted.votes.length
      expect(vote_count).must_equal Work.all.max_by { |work| work.votes.length }.votes.length
    end

    it "returns the first work alphabetically in case of tie" do
      work = works(:one)
      top_work = Work.spotlight
      expect(top_work).must_equal work
    end

    it "should return nil if there are no works" do
      Work.all.each do |work|
        work.destroy
      end

      top_voted = Work.spotlight
      expect(top_voted).must_be_nil
    end
  end

  describe "list_of" do
    it "returns an array of only one type of work" do
      works = Work.list_of("album")
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "album"
      end

      works = Work.list_of("book")
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "book"
      end

      works = Work.list_of("movie")
      expect(works).must_be_instance_of Array

      works.each do |work|
        expect(work).must_be_instance_of Work
        expect(work.category).must_equal "movie"
      end
    end

    it "returns an empty array if there are no works" do
      Work.all.each do |work|
        if work.category == "album"
          work.votes.each do |vote|
            vote.destroy
          end
          work.destroy
        end
      end

      works = Work.list_of("album")

      expect(works).must_be_instance_of Array
      expect(works.length).must_equal 0
    end
  end

  describe "vote_count" do
    it "returns the total number of votes on a work" do
      work = works(:one)
      count = work.vote_count
      expect(count).must_equal 2
    end

    it "returns 0 when the work has no votes" do
      no_votes = works(:three)
      count = no_votes.vote_count
      expect(count).must_equal 0
    end
  end
end
