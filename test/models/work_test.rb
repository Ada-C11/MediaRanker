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
    describe "self.top_ten(category)" do
      it "will return top 10 of a given category given more than 10 works" do
        expect(Work.top_ten("book").count).must_equal 10
        book_votes = Hash.new(0)
        Work.top_ten("book").each do |work|
          book_votes[work.id] = work.votes.count
        end
        expect(book_votes.to_s).must_equal "{6=>13, 5=>12, 13=>11, 11=>11, 14=>11, 7=>11, 17=>11, 16=>10, 8=>10, 12=>10}"
      end

      it "will return all of a given category if less than 10" do
        expect(Work.top_ten("Movie")).must_equal [works(:one)]
      end

      it "will return [] if no items in a given category" do
        expect(Work.top_ten("album")).must_equal []
      end
    end

    describe "def self.spotlight" do
      it "will return a work with most votes" do
        expect(Work.spotlight.id).must_equal 6
      end

      it "will return nil if no works" do
        Work.all.each do |work|
          work.destroy
        end
        expect(Work.count).must_equal 0
        expect(Work.spotlight).must_be_nil
      end
    end
  end
end
