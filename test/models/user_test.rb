require "test_helper"

describe User do
  let (:user) {
    User.first
  }
  describe "validations" do
    it "must be valid" do
      valid_user = user.valid?
      expect(valid_user).must_equal true
    end

    it "requires a username" do
      user.username = nil
      expect(user.valid?).must_equal false
      expect(user.errors.messages).must_include :username
      expect(user.errors.messages[:username]).must_equal ["can't be blank"]
    end

    it "username has to be unique" do
      first_username = user.username
      new_user = User.new(username: first_username)
      expect(new_user.valid?).must_equal false
      expect(new_user.errors.messages).must_include :username
      expect(new_user.errors.messages[:username]).must_equal ["has already been taken"]
    end
  end

  describe "relationships" do
    it "can have 0 votes" do
      votes = user.votes
      expect(votes.length).must_equal 0
    end

    it "can have 1 or more votes" do
      vote = Vote.create(date: Date.today,
                         work_id: Work.first.id,
                         user_id: User.first.id)
      user.votes << vote

      another_vote = Vote.create(date: Date.today,
                                 work_id: Work.last.id,
                                 user_id: User.last.id)

      user.votes << another_vote
      user.save

      expect(user.votes).must_include vote
      expect(user.votes).must_include another_vote
      expect(user.votes.first).must_be_instance_of Vote
      expect(user.votes.last).must_be_instance_of Vote
    end
  end
end
