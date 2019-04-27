require "test_helper"

describe Vote do
  let(:vote) { votes(:vote_1) }

  it "must be valid" do
    value(vote).must_be :valid?
  end

  it "must require a user_id" do
    vote.username = ""

    expect(user.valid?).must_equal false
    expect(user.errors.messages).must_include :username
  end

  describe "relationships" do
    it "can have many votes" do
      expect(user.votes.count).must_be :>=, 0
      user.votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end
  end
end
