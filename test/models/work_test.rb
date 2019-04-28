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
      it "must return the work with the top # of votes" do
        works = Work.all
        spotlight = works.media_spotlight

        expect(spotlight.title).must_equal "Blonde"
      end

      it "will only return one work if there is a tie" do
        tie_work = works(:movie)
        new_user = User.create(username: "tiemaker")
        Vote.create(work_id: tie_work.id, user_id: user.id)
        Vote.create(work_id: tie_work.id, user_id: new_user.id)

        works = Work.all
        spotlight = works.media_spotlight

        expect(spotlight.title).must_equal "The Thing"
      end
    end

    describe "top_ten" do
      it "returns works with the top number of votes given a category (returns all in category if less than 10)" do
        works = Work.all
        top_ten = works.top_10("album")

        expect(top_ten.count).must_equal 3
      end
    end
  end
end
