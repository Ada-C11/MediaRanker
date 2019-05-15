require "test_helper"

describe User do
  let(:user) { users(:one) }
  let(:work) { works(:one) }
  describe "Validations" do
    it "will be valid" do
      expect(user.valid?).must_equal true
    end

    it "will not be valid without username" do
      user.username = nil
      expect(user.save).must_equal false
    end

    it "will not be valid with same username twice" do
      user_new = User.new(username: user.username)
      expect(user_new.save).must_equal false
    end
  end

  describe "relations" do
    it "will have 0 votes" do
      user = User.new(username: "no votes")
      expect(user.votes).must_equal []
    end

    it "will have 1 or more works through votes" do
      user.votes << votes(:two)
      # expect(user.votes.find_by(user_id: work.id).work_id).must_equal work.id
      expect(user.works).must_include work
      expect(user.works.find(work.id).id).must_equal work.id
      expect(work.users).must_include user
      expect(work.users.last.id).must_equal user.id
    end
  end

  describe "custom methods" do
  end
end
