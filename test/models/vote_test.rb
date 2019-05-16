require "test_helper"

describe Vote do
  before do
    @vote = Vote.first
  end

  describe "validations" do
    it "passes validations with good data" do
      expect(@vote).must_be :valid?
    end

    it "rejects an invalid vote, so a user cannot vote for the same work twice" do
      invalid_vote = Vote.new(user_id: @vote.user_id, work_id: @vote.work_id)
      result = invalid_vote.save
      expect(result).must_equal false
    end
  end
end
