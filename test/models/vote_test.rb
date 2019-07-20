require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_two) }
  let(:user) { users(:user2) }
  let(:work) { works(:one) }
  let(:work3) { works(:three) }
  describe "validations" do
    it "must be valid" do
      value(vote).must_be :valid?
    end

    it "requires a user id" do
      vote.user_id = nil
      expect(vote.save).must_equal false
      expect(vote.errors.messages).must_include :user
      expect(vote.errors.messages[:user]).must_equal ["must exist"]
    end

    it "requires a work id" do
      vote.work_id = nil
      expect(vote.save).must_equal false
      expect(vote.errors.messages).must_include :work
      expect(vote.errors.messages[:work]).must_equal ["must exist"]
    end

    it "requires a unique work_id and user_id" do
      duplicate_vote = Vote.new(user_id: user.id, work_id: work.id)
      expect(duplicate_vote.save).must_equal false
      expect(duplicate_vote.errors.messages).must_include :user
      expect(duplicate_vote.errors.messages[:user]).must_equal ["has already voted for this work"]
    end
  end

  describe "relationships" do
    it "belongs to a work" do
      vote.work = work3
      expect(vote.work_id).must_equal work3.id
    end

    it "belongs to a user" do
      test_user = vote.user
      expect(vote.user_id).must_equal test_user.id
    end

    it "can set the user through the user_id" do
      new_user = User.create(name: "chuck")
      vote.user_id = new_user.id
      expect(vote.user).must_equal new_user
    end

    it "can set the work through the work_id" do
      new_work = work3
      vote.work_id = new_work.id
      expect(vote.work_id).must_equal work3.id
    end
  end
end
