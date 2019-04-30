require 'test_helper'

describe Vote do
  describe 'creation' do
    it 'can create a vote' do
      user = users(:sansa)
      work = works(:poodr)
      vote = Vote.new(user: user, work: work)
      result = vote.valid?
      result.must_equal true
    end

    it 'cannot create a vote if user is nil' do
      work = works(:poodr)
      vote = Vote.new(user: nil, work: work)
      result = vote.valid?
      result.must_equal false
    end
  end

  describe 'relations' do
    it 'has a user' do
      vote = votes(:one)
      vote.must_respond_to :user
      vote.user.must_be_kind_of User
    end

    it 'has a work' do
      vote = votes(:one)
      vote.must_respond_to :work
      vote.work.must_be_kind_of Work
    end
  end

  describe 'validations' do
    before do
      @user1 = users(:arya)
      @user2 = users(:sansa)
      @work1 = works(:startrek)
      @work2 = works(:homecoming)
    end
    it 'allows one user to vote for multiple works' do
      vote1 = Vote.new(user: @user2, work: @work1)
      vote1.save!
      vote2 = Vote.new(user: @user2, work: @work2)
      vote2.valid?.must_equal true
    end

    it 'allows multiple users to vote for a work' do
      vote1 = Vote.new(user: @user1, work: @work1)
      vote1.save!
      vote2 = Vote.new(user: @user2, work: @work1)
      vote2.valid?.must_equal true
    end

    it "doesn't allow the same user to vote for the same work twice" do
      vote1 = Vote.new(user: @user1, work: @work1)
      vote1.save!
      vote2 = Vote.new(user: @user1, work: @work1)
      vote2.valid?.must_equal false
      vote2.errors.messages.must_include :user
    end
  end
end
