require "test_helper"

describe Work do
  let(:work) { works(:book) }
  let(:user) {
    User.create(username: "test_user")
  }

  describe "validation" do
    it "must be valid" do
      valid_work = work.valid?

      expect(valid_work).must_equal true
    end

    it "requires a title" do
      work.title = nil

      expect(work.valid?).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      dup_work = Work.new(title: work.title)

      expect(dup_work.save).must_equal false
      expect(dup_work.errors.messages).must_include :title
      expect(dup_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "can have many votes" do
      new_vote = Vote.create(work_id: work.id, user_id: user.id)

      expect(work.votes).must_include new_vote
      expect(work.votes.count).must_equal 2
    end

    it "can have many users through votes" do
      new_vote = Vote.create(work_id: work.id, user_id: user.id)

      expect(work.users).must_include user
      expect(work.users.count).must_equal 2
    end
  end

  describe "custom methods" do
    describe "media_spotlight" do
    end 

    describe "top_ten" do
    end 
  end
end
