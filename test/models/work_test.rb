# frozen_string_literal: true

require 'test_helper'
require 'pry'
describe Work do
  let(:album) { works(:album) }
  let(:user) { users(:one) }
  let(:vote1) { votes(:vote1) }
  let(:vote2) { votes(:vote2) }

  it 'must be valid' do
    value(album).must_be :valid?
  end

  describe 'validations' do
    it 'requires a title' do
      # Arrange
      album.title = nil

      # Act
      valid_work = album.valid?

      # Assert
      expect(valid_work).must_equal false
      expect(album.errors.messages).must_include :title
      expect(album.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

  describe 'relationships' do
    it 'has many votes' do
      album.votes << vote1
      album.votes << vote2
      expect(album.votes.length).must_equal 2
    end
  end

  describe 'top_10 method' do
    it 'will return up to 10 works (if no works have upvotes, will return 10 works)' do
      results = Work.top_ten('book')
      expect(results.length).must_equal 10
    end
  end

  describe 'spotlight' do
    it 'selects a random work from a media category' do
      spotlight = Work.spotlight
      expect(spotlight).must_be_kind_of Work
    end

    it 'will return nil if there are no works' do
      Work.destroy_all
      spotlight = Work.spotlight
      expect(spotlight).must_equal nil
    end
  end
end # end of describe Work block
