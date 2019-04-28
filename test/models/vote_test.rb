require "test_helper"

describe Vote do
  let(:vote) { Vote.new }

  describe "validations" do
    it "is valid when all fields are present" do
      result = votes(:one).valid?

      expect(result).must_equal true
    end

    it "is invalid when user is not present" do
      invalid_vote = votes(:one)
      invalid_vote.user = nil

      result = invalid_vote.valid?

      expect(result).must_equal false
      expect(invalid_vote.errors.messages).must_include :user
    end

    it "is invalid when work is not present" do
      invalid_vote = votes(:one)
      invalid_vote.work = nil

      result = invalid_vote.valid?

      expect(result).must_equal false
      expect(invalid_vote.errors.messages).must_include :work
    end

    it "is valid when user vote for multiple different works" do
      user = users(:chris)
      work = works(:hp7)
      work2 = works(:nightingale)

      expect {
        Vote.create(user: user, work: work)
      }.must_change "Vote.count", 1

      expect {
        Vote.create(user: user, work: work2)
      }.must_change "Vote.count", 1
    end

    it "is valid when multiple users vote for same work" do
      user = users(:chris)
      user2 = users(:dee)
      work = works(:hp7)

      expect {
        Vote.create(user: user, work: work)
      }.must_change "Vote.count", 1

      expect {
        Vote.create(user: user2, work: work)
      }.must_change "Vote.count", 1
    end

    it "is invalid when user/work pair is not unique" do
      user = users(:chris)
      work = works(:hp7)

      expect {
        Vote.create(user: user, work: work)
      }.must_change "Vote.count", 1

      expect {
        Vote.create(user: user, work: work)
      }.wont_change "Vote.count"
    end
  end

  describe "relations" do
    it 'can set the user through "user"' do
      user = users(:dee)
      vote = Vote.new(work: works(:freesolo))

      vote.user = user

      expect(vote.user_id).must_equal user.id
    end

    it 'can set the user through "user_id"' do
      user = users(:dee)
      vote = Vote.new(work: works(:freesolo))

      vote.user_id = user.id

      expect(vote.user).must_equal user
    end

    it 'can set the work through "work"' do
      work = works(:freesolo)
      vote = Vote.new(user: users(:dee))

      vote.work = work

      expect(vote.work_id).must_equal work.id
    end

    it 'can set the work through "work_id"' do
      work = works(:freesolo)
      vote = Vote.new(user: users(:dee))

      vote.work_id = work.id

      expect(vote.work).must_equal work
    end
  end
end
