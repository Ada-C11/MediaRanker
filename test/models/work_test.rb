require "test_helper"
require 'pry'

describe Work do
  let(:vote1) { votes(:one) }
  let(:vote2) { votes(:two) }
  let(:work) { works(:one) }

  describe "validations" do 
    before do 
      @work = Work.new(
        title: "test work",
        creator: "test creator",
        category: "book",
        publication_year: 1990,
        description: "test description"
      )
    end

    it "is valid with good data" do 
      result = @work.valid?
      
      expect(result).must_equal true
    end

    it "is invalid without a title" do 
      @work.title = nil

      expect(@work.valid?).must_equal false
    end

    it "is invalid for duplicate creator and title" do 
      @work.creator = Work.first.creator
      @work.title = Work.first.title 

      expect(@work.valid?).must_equal false
    end

    it "is invalid when creator is nil" do 
      @work.creator = nil

      expect(@work.valid?).must_equal false
    end

    it 'is invalid without a publication_year' do 
      @work.publication_year = nil 

      expect(@work.valid?).must_equal false
    end

    it 'is invalid when publication year is not integer' do 
      @work.publication_year = "string"

      expect(@work.valid?).must_equal false
    end

    it 'is invalid when publication year is less than 0' do 
      @work.publication_year = -1

      expect(@work.valid?).must_equal false
    end

    it 'is invalid when publication year is after today' do 
      @work.publication_year = Date.today.year + 1

      expect(@work.valid?).must_equal false
    end
  end

  describe "relationships" do 
    it "has many votes" do 
      work.votes << vote1
      expect(work.votes.first).must_equal vote1
    end
  end
end
