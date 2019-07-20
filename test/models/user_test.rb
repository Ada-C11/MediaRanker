require "test_helper"

describe User do
  let(:user) { users(:user1) }
  let(:vote) { votes(:vote_two) }
  let(:vote2) { votes(:vote_one) }

  describe "validations" do
    it "must be valid" do
      value(user).must_be :valid?
    end
    it "requires a name" do
      user.name = nil
      expect(user.save).must_equal false
      expect(user.errors.messages).must_include :name
      expect(user.errors.messages[:name]).must_equal ["can't be blank"]
    end

    it "requires a unique name" do
      duplicate_user = User.new(name: "Mollie")
      expect(duplicate_user.save).must_equal false
      expect(duplicate_user.errors.messages).must_include :name
      expect(duplicate_user.errors.messages[:name]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "has many votes" do
      user_twelve = users(:user12)
      vote_1 = votes(:vote_5)
      vote_2 = votes(:vote_6)
      expect(user_twelve.votes).must_include vote_1
      expect(user_twelve.votes).must_include vote_2
    end

    it "can have 0 votes" do
      Vote.delete_all
      expect(user.votes.length).must_equal 0
    end

    it "can set the vote through the vote_id" do
      new_vote = vote2
      user.vote_ids = vote2.id
      expect(user.votes.last).must_equal new_vote
    end
  end
end
