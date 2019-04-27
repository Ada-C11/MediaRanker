require "test_helper"
require "pry"

describe Work do
  let(:work) { works(:one) }
  describe "validations" do
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
      work_two = works(:two)
      top_work = Work.top_media
      expect(top_work).must_equal work_two
      expect(top_work.title).must_equal "Homecoming"
    end
    it "will return the first work if there are no votes" do
      Vote.delete_all
      expect(Work.top_media).must_equal works(:one)
    end
    it "will return the first work if there is a tie" do
      Vote.delete_all
      vote = Vote.create(work_id: works(:one), user_id: users(:user1))
      vote = Vote.create(work_id: works(:two), user_id: users(:user1))
      expect(Work.top_media).must_equal works(:one)
    end
    it "will return nil if there are no works" do
      Vote.delete_all
      Work.delete_all
      expect(Work.top_media).must_equal nil
    end
  end

  describe "top_ten" do
    it "will return a list of works of only one category" do
    end
    it "will sort works in descending order" do
    end
    it "will return a list of ten works" do
    end
    it "will return an empty array if there are no works in that category" do
    end
    it "will return a list of ten works if there are no votes" do
    end
  end
end
