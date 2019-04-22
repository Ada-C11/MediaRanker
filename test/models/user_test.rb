require "test_helper"

describe User do
  let(:user) { users(:one) }
  let(:work) { works(:one) }
  describe "Validations" do
    it "will be valid" do
      expect(user.valid?).must_equal true
    end

    it "will not be valid without name" do
      user.name = nil
      expect(user.save).must_equal false
    end

    it "will not be valid with same name twice" do
      user_new = User.new(name: user.name)
      expect(user_new.save).must_equal false
    end
  end

  describe "relations" do
    it "will have 0 works" do
      expect(user.works).must_equal []
    end

    it "will have 1 or many works" do
      user.works << work
      expect(user.works).must_include work
      expect(user.works.last.id).must_equal work.id
      expect(work.users).must_include user
      expect(work.users.last.id).must_equal user.id
    end
  end

  describe "custom exceptions" do
  end
end
