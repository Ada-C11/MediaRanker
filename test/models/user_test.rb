require "test_helper"

describe User do
  let(:user) { users(:laneia) }
  let(:work) { works(:one) }

  it "must be valid" do
    value(user).must_be :valid?
  end

  it "has all required fields" do
    fields = [:username, :joined, :votes, :works]

    fields.each do |field|
      expect(user).must_respond_to field
    end
  end

  describe "relationships" do
    it "has many votes" do
      votes = user.votes
      expect(user).must_be_instance_of User
      expect(votes.length).must_equal 3
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it "can have 0 votes" do
      kim = users(:three)
      votes = kim.votes
      expect(kim).must_be_instance_of User
      expect(votes.length).must_equal 0
      expect(kim.valid?).must_equal true
    end

    it "has many works through votes" do
      works = user.works
      expect(user).must_be_instance_of User
      expect(works.length).must_be :>=, 1
      works.each do |work|
        expect(work).must_be_instance_of Work
      end
    end
  end

  describe "validations" do
    it "must have a username" do
      user.username = nil
      valid = user.valid?
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]

      user.username = "laneia"
      valid = user.valid?
      expect(valid).must_equal true
    end

    it "must have a joined date" do
      user.joined = nil
      valid = user.valid?
      expect(valid).must_equal false
      expect(user.errors.messages).must_include :joined
      expect(user.errors.messages[:joined]).must_equal ["can't be blank"]

      user.joined = "2019-06-07"
      valid = user.valid?
      expect(valid).must_equal true
    end
  end

  describe "vote_date" do
    it "returns date user voted on work" do
      date = user.vote_date(work)
      expect(date).must_equal Date.parse("2019-06-14")
    end

    it "returns nil when user has not voted on work" do
      date = user.vote_date(works(:three))
      expect(date).must_be_nil
    end
  end

  describe "vote_count" do
    it "returns number of upvotes user has made" do
      count = user.vote_count
      expect(count).must_equal 3
    end

    it "returns 0 when the user has not voted" do
      new_user = users(:three)
      count = new_user.vote_count
      expect(count).must_equal 0
    end
  end

  describe "eligible_to_vote" do
    let(:new_work) { Work.new(category: "movie", title: "Black Panther") }

    it "returns true if user has not voted on work" do
      eligible = users(:three).eligible_to_vote? new_work
      expect(eligible).must_equal true
    end

    it "returns false if user has voted on work" do
      new_vote = Vote.new(user: users(:three), work: new_work, date: Date.today)
      new_vote.save
      eligible = users(:three).eligible_to_vote? new_work
      expect(eligible).must_equal false
    end
  end
end
