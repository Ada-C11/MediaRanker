require "test_helper"

describe User do
  let(:user) { users(:one) }

  describe 'validations' do
    it 'is valid when all fields are present' do
      result = user.valid?
      expect(result).must_equal true
    end

    it 'must have a username' do
      user.username = nil
      result = user.valid?

      expect(result).must_equal false
    end

    it 'must have a unique username' do
      user2 = User.new(username: "superfresh")
      result = user2.save

      expect(result).must_equal false
    end

  end

  describe 'relationships' do
    it 'can have many votes' do
      votes = user.votes

      expect(votes.length).must_equal 2
      votes.each do |vote|
        expect(vote).must_be_instance_of Vote
      end
    end

    it 'can have zero votes' do
      new_user = User.new
      votes = new_user.votes

      expect(votes.length).must_equal 0
    end
  end

  describe 'has_voted?' do
    it 'can return true if user has already voted on the work' do
      work = user.votes.first.work_id
      result = user.has_voted?(work)

      expect(result).wont_be_nil
    end
  end
end
