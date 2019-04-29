require "test_helper"

describe Work do
  let(:work) { works(:spaghetti) }
  let(:kim) { users(:kim) }
  let(:aj) { users(:aj) }

  it "must be valid" do
    expect(work).must_be :valid?
  end

  describe "validations" do
    it "must have a category" do
      work.category = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false

      expect(work.errors.messages).must_include :category
      expect(work.errors.messages[:category]).must_equal ["can't be blank"]
    end

    it "must have a title" do
      work.title = nil

      valid_work = work.valid?

      expect(valid_work).must_equal false
      expect(work.errors.messages).must_include :title
      expect(work.errors.messages[:title]).must_equal ["can't be blank"]
    end

    it "requires a unique title" do
      duplicate_work = Work.new(category: "book", title: "War and Peace", creator: "Michael Jackson")

      expect(duplicate_work.save).must_equal false

      expect(duplicate_work.errors.messages).must_include :title
      expect(duplicate_work.errors.messages[:title]).must_equal ["has already been taken"]
    end
  end

  describe "relations" do
    # has many votes
    # has many users through votes
    it "has a list of votes" do
      work.must_respond_to :votes
      work.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end

    it "has a list of voting users" do
      work.must_respond_to :users
      work.users.each do |user|
        user.must_be_kind_of User
      end
    end
  end

  describe "top_ten" do
    it "must return only the top ten works" do
    end

    it "must return an empty arry of no works" do
    end
  end

  describe "spotlight" do
    it "must return the most voted on work" do
    end

    it "must return nil if no works" do
    end
  end
end
