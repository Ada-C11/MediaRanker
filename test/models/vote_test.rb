require "test_helper"

describe Vote do
  let(:vote) { votes(:vote1) }

  describe 'validations' do
    it 'is valid when all fields are present' do
      result = vote.valid?
      expect(result).must_equal true
    end

  end
end
