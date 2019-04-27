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
    it "can have no votes" do
      work = Work.new(title: "Something Else", category: "book")
      expect(work.votes.to_a).must_equal []
    end

    it "will have one or more votes" do
      work.votes << votes(:two)
      expect(work.votes.to_a).must_equal [votes(:one), votes(:two)]
    end

    it "will have relationship through votes with users" do #may need to add additional tests here
      work.votes << votes(:two)
      expect(work.votes.find_by(user_id: user.id).user_id).must_equal user.id
      expect(work.users.include?(user)).must_equal true
      expect(user.works).must_include work
      expect(work.users).must_include user
    end
  end

  describe "custom methods" do
  end
end
