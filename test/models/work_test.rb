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
    it "gets 10 works from each category" do
    end

    it "returns nil for catagories without any works" do
    end

    it "returns less than 10 works for categories with less than 10 works"
  end

  describe "self.spotlight" do
    it "returns a Work" do
    end
    it "returns nil if there are no works" do
    end
  end
end
