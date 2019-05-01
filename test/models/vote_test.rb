require "test_helper"

describe Vote do
  describe "Validations" do
    before do
      @vote = Vote.new({ user_id: users.first.id, work_id: works.first.id })
    end

    it "must be valid" do
      result = @vote.valid?

      expect(result).must_equal true
    end

    it "is invalid without user_id" do
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

  describe "Relations" do
    before do
      @vote = votes.first
    end
    it "has a work" do
      vote = votes(:one)
      vote.work.must_equal works(:one)
    end

    it "has a user" do
      vote = votes(:one)
      vote.user.must_equal users(:one)
    end

    it "can set the work" do
      vote = Vote.new
      vote.work = works(:one)
      vote.work_id.must_equal works(:one).id
    end

    it "can set the user" do
      vote = Vote.new
      vote.user = users(:one)
      vote.user_id.must_equal users(:one).id
    end
  end
end
