require "test_helper"

describe Vote do
  # let(:vote) { Vote.new }

  # it "must be valid" do
  #   value(vote).must_be :valid?
  # end

  describe "Validations" do
    before do
      @vote = Vote.new({ user_id: users.first.id, work_id: works.first.id })
    end
    it "Validates with good data" do
      result = @vote.valid?

      expect(result).must_equal true
    end

    it "Wont validate a vote without a user_id" do
      @vote.user_id = nil

      result = @vote.valid?

      expect(result).must_equal false
    end
    it "Wont validate a vote without a work_id" do
      @vote.work_id = nil

      result = @vote.valid?

      expect(result).must_equal false
    end
  end
end
