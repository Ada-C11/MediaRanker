require "test_helper"

describe Vote do
  let(:vote) { votes(:vote1) }

  describe 'validations' do
    it 'is valid when all fields are present' do
      result = vote.valid?
      expect(result).must_equal true
    end

    it 'requires user_id' do
      vote.user_id = nil
      result = vote.valid?
      expect(result).must_equal false
    end

    it 'requires work_id' do
      vote.work_id = nil
      result = vote.valid?
      expect(result).must_equal false
    end
  end

  describe 'relationships' do
    let(:user) { users(:one) }
    let(:work) { works(:book1) }

    it 'belongs to a user' do
      user_test = vote.user_id
      expect(user_test).must_equal user.id
    end

    it 'belongs to a work' do
      work_test = vote.work_id
      expect(work_test).must_equal work.id
    end
  end
end
