require 'test_helper'

describe User do
  describe 'validations' do
    it 'requires a username' do
      user = User.new
      user.valid?.must_equal false
      user.errors.messages.must_include :username
    end

    it 'rejects a user with the same username' do
      user = User.new(username: 'sansastark')
      result = user.save
      result.must_equal false
      user.errors.messages.must_include :username
    end
  end

  describe 'relations' do
    it 'has a list of votes' do
      arya = users(:arya)
      arya.must_respond_to :votes
      arya.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end
  end
end
