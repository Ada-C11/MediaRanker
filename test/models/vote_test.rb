require "test_helper"

describe Vote do
  it "must be valid" do
    vote = Vote.create(user_id: users(:one).id, work_id: works(:one).id)
    expect(vote.valid?).must_equal true
  end

  describe "validations" do
    it "requires a unique user_id and work_id" do
      vote = Vote.create(user_id: users(:one).id, work_id: works(:one).id)
      dup_vote = Vote.new(user_id: users(:one).id, work_id: works(:one).id)
      expect(dup_vote.save).must_equal false
      expect(dup_vote.errors.messages).must_include :user_id
      expect(dup_vote.errors.messages[:user_id]).must_equal ["has already been taken"]
    end
  end
end
