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

  describe "relationships" do
    before do
      @vote = votes.first
    end
    it "can access its user through .user" do
      user = @vote.user

      expect(user).must_be_instance_of User
      expect(user.id).must_equal @vote.user_id
    end

    it "can access its work through .work" do
      work = @vote.work

      expect(work).must_be_instance_of Work
      expect(work.id).must_equal @vote.work_id
    end

    it "can set work through work_id" do
      work = works(:three)
      @vote.work_id = work.id

      expect(@vote.work).must_equal work
    end
    it "can set user through user_id" do
      user = users(:fred)
      @vote.user_id = user.id

      expect(@vote.user).must_equal user
    end
  end
end
