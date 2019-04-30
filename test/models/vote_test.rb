# frozen_string_literal: true

require 'test_helper'
require 'pry'

describe Vote do
  let(:album) { works(:album) }
  let(:user) { users(:one) }
  let(:vote1) { votes(:vote1) }
  let(:vote2) { votes(:vote2) }

  describe 'validations' do
    it 'requires a work_id' do
      # Arrange
      vote1.work_id = nil

      # Act
      valid_vote = vote1.valid?

      # Assert
      expect(valid_vote).must_equal false
      expect(vote1.errors.messages).must_include :work_id
      # expect(vote1.errors.messages[:work_id]).must_equal ["must exist"]
    end

    it 'requires a user_id' do
      # Arrange
      vote1.user_id = nil

      # Act
      valid_vote = vote1.valid?

      # Assert
      expect(valid_vote).must_equal false
      expect(vote1.errors.messages).must_include :user
      expect(vote1.errors.messages[:user]).must_equal ['must exist']
    end
  end

  describe 'relationships' do
    it 'belongs to work' do
      album.votes << vote1
      album.votes << vote2
      expect(album.votes.length).must_equal 2
    end

    it 'belongs to user' do
      # Arrange
      user = User.create(username: 'new user')
      # Act
      vote1.user_id = user.id

      # Assert
      expect(vote1.user_id).must_equal user.id
    end
  end
end
