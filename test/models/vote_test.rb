require "test_helper"

describe Vote do
  before do
    @user = User.first

    @work = Work.first
  end

  describe "validations" do
    it "must be valid" do
      vote = Vote.create(user_id: @user.id, work_id: @work.id)

      value(vote).must_be :valid?
    end

    it "is invalid if another vote exists with the same user_id and work_id" do
      vote = Vote.create(user_id: @user.id, work_id: @work.id)

      vote2 = Vote.create(user_id: @user.id, work_id: @work.id)
      expect(vote2).wont_be :valid?
    end
  end

  describe "relations" do
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
      vote.work = works(:return)
      vote.work_id.must_equal works(:one).id
    end

    it "can set the user" do
      vote = Vote.new
      vote.user = users(:bender)
      vote.user_id.must_equal users(:one).id
    end
  end
end
