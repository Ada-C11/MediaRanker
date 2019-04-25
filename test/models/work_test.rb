# frozen_string_literal: true

require 'test_helper'
require 'pry'
describe Work do
  let(:album) { works(:album) }
  let(:user) {users(:one)}

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

  describe "relationships" do
    it "can be voted on" do
      album.upvote_by user

      expect(album.cached_votes_total).must_equal 1
      expect(user.voted_for?(album)).must_equal true
    end
  end

  describe 'top_10 method' do
    it 'will return up to 10 works (if no works have upvotes, will return 10 works)' do
      results = Work.top_ten('book')
      expect(results.length).must_equal 10
    end

    it 'can return only works that have upvotes if at least one work has upvotes' do
      results = Work.top_ten('album')
      expect(results.length).must_equal 4
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
