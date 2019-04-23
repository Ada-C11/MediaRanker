require "test_helper"

describe User do
  let(:user) { users(:one) }
  let(:work) { works(:one) }
  describe "Validations" do
    it "will be valid" do
      expect(work.valid?).must_equal true
    end

    it "will not be valid without title" do
      work.title = nil
      expect(work.save).must_equal false
    end

    it "will not be valid without category" do
      work.category = nil
      expect(work.save).must_equal false
    end

    it "will not be valid with same title twice" do
      work_new = Work.new(title: work.title, category: "book")
      expect(work_new.save).must_equal false
    end
  end

  describe "relations" do
    it "will have 0 users" do
      expect(work.users).must_equal []
    end

    it "will have 1 or many users" do
      work.users << user
      expect(work.users).must_include user
      expect(work.users.last.id).must_equal user.id
      expect(user.works).must_include work
      expect(user.works.last.id).must_equal work.id
    end
  end

  describe "custom methos" do
  end
end
