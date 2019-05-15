require "test_helper"

describe Work do
  let(:work) { works(:one) }
  let(:vote) { votes(:vote_1) }
  it "must be valid" do
    expect(work.valid?).must_equal true
  end

  describe "validations" do
    it "requires a title" do
      work.title = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
    end

    it "requires a category" do
      work.category = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :category
    end

    it "requires a creator" do
      work.creator = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :creator
    end

    it "requires a description" do
      work.description = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :description
    end
  end

  describe "relationships" do
    it "can have many trips" do
      work = Work.first

      expect(work.votes.count).must_be :>=, 0
      work.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end

  describe "find_highest" do
    it "returns a work object" do
      expect(Work.find_highest).must_be_kind_of Work
    end

    it "returns the highest voted object" do
      expect(Work.find_highest).must_equal works(:one)
    end

    it "returns only one object if there are two with the same number of votes" do
    end

    it "returns nil if no work" do
      Work.all.each do |work|
        work.destroy
      end
      expect(Work.find_highest).must_be_nil
    end
  end

  describe "list_works" do
    it "returns an array" do
      expect(Work.list_works("album")).must_be_kind_of Array
    end

    it "returns the work with the highest vote first" do
      expect(Work.list_works("album").first).must_equal works(:two)
    end

    it "returns an empty array if no works" do
      Work.destroy_all
      expect(Work.list_works("album").length).must_equal 0
    end
  end
end
