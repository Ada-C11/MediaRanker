require "test_helper"

describe Work do
  describe "validations" do
    let(:work) { works(:one) }

    it "must be valid" do
      value(work).must_be :valid?
    end

    it "requires a title" do
      work.title = nil
      valid_work = work.valid?
      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires specific categories" do
      wrong_category = Work.new(title: "Hello", category: "record")
      expect(wrong_category.save).must_equal false
      expect(wrong_category.errors.messages).must_include :category
      expect(wrong_category.errors.messages[:category]).must_equal ["is not included in the list"]
    end
  end

  describe "relationships" do
    let(:work) { works(:one) }
    let(:work3) { works(:three) }

    it "can have 0 votes" do
      expect(work3.votes.count).must_equal 0
    end

    it "can have many votes" do
      expect(work.votes.length).must_equal 2
    end

    it "can set the vote through the vote_id" do
      new_vote = votes(:vote_7)
      work.vote_ids = new_vote.id
      expect(work.votes.last).must_equal new_vote
    end
  end

  describe "top_media" do
    it "will return work with the most votes" do
    end
    it "will return the first work if there are no votes" do
    end
    it "will return the first work if there is a tie" do
    end
    it "will return nil if there are no works" do
    end
  end

  describe "top_ten" do
    it "will return a list of works of only one category" do
    end
    it "will sort works in descending order" do
    end
    it "will return a list of ten works max" do
    end
    it "will return an empty array if there are no works in that category" do
    end
    it "will return a list of ten works if there are no votes" do
    end
  end
end
