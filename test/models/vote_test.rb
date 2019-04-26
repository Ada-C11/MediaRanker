require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  describe "relations" do
    it "has a user and work" do
      vote = votes(:custom2)
      vote.user.must_equal users(:custom1)
      vote.work.must_equal works(:custom1)
    end
  end

  describe "vote method" do
    it "returns the correct vote given a user and work" do
      work = works(:custom1)
      user = users(:custom1)
      expect (vote.valid?).must_equal false #is this false because I don't have a new action or because it doesn't have a user id or workid
      expect(Vote.vote(user, work)).must_equal votes(:custom2)
    end

    it "returns nil if invalid user or work given" do
      expect(Vote.vote(1, 2)).must_be_nil
    end
  end
end
