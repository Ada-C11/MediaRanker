require "test_helper"

describe Vote do
  before do
    @vote = Vote.create(
      user_id: User.first.id,
      work_id: Work.first.id,
    )
  end
  describe "validations" do
    it "is valid when the user has not voted on the work before" do
      result = @vote.valid?
      expect(result).must_equal true
    end

    it "is invalid if a user votes for the same work more than once" do
      test_vote = Vote.new(
        user_id: User.first.id,
        work_id: Work.first.id,
      )

      result = test_vote.valid?

      expect(result).must_equal false
    end

    it "is valid if the same user votes for a different work" do
      test_vote = Vote.new(
        user_id: User.first.id,
        work_id: Work.last.id,
      )

      result = test_vote.valid?

      expect(result).must_equal true
    end

    it "is valid if a different user votes for the same work" do
      test_vote = Vote.new(
        user_id: User.last.id,
        work_id: Work.first.id,
      )

      result = test_vote.valid?

      expect(result).must_equal true
    end
  end
end
