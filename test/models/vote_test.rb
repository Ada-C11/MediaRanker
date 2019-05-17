require "test_helper"

describe Vote do
  let (:vote) {
    Vote.new(date: Date.today,
             work_id: Work.first.id,
             user_id: User.first.id)
  }

  describe "validations" do
    it "must be valid" do
      expect(vote.valid?).must_equal true
    end

    it "requires work_id" do
      vote.work_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :work_id
      expect(vote.errors.messages[:work_id]).must_equal ["can't be blank"]
    end

    it "requires user_id" do
      vote.user_id = nil
      expect(vote.valid?).must_equal false
      expect(vote.errors.messages).must_include :user_id
      expect(vote.errors.messages[:user_id]).must_equal ["can't be blank"]
    end
  end

  describe "relationships" do
    it "belongs to a user" do
      user = User.first
      vote.user = user

      expect(vote.user_id).must_equal user.id
    end

    it "belongs to a work" do
      work = Work.first
      vote.work = work

      expect(vote.work_id).must_equal work.id
    end

    it "can set the user through user_id" do
      user = User.first
      vote.user_id = user.id
      expect(vote.user).must_equal user
    end

    it "can set the work throught work_id" do
      work = Work.first
      vote.work_id = work.id
      expect(vote.work).must_equal work
    end
  end

  describe "upvote" do
    it "can upvote a work" do
      expect {
        Vote.upvote(date: Date.today, work_id: Work.first.id, user_id: User.first.id)
      }.must_change "Vote.count", 1
    end

    it "return nil if the user has already voted the work" do
      Vote.upvote(date: Date.today - 3, work_id: Work.first.id, user_id: User.first.id)
      vote = Vote.upvote(date: Date.today, work_id: Work.first.id, user_id: User.first.id)
      expect(vote).must_equal nil
    end
  end
end
