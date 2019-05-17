require 'test_helper'

describe Work do
  describe 'validations' do
    it 'requires a title' do
      work = Work.new
      result = work.valid?
      expect(result).must_equal false
      work.errors.messages.must_include :title
    end

    it 'requires unique titles within categories' do
      work = Work.new(title: 'Lemonade', category: categories(:album))
      work.valid?.must_equal false
      work.errors.messages.must_include :title
    end

    it 'does not require a unique title within different categories' do
      work = Work.new(title: 'Lemonade', category: categories(:movie))
      work.valid?.must_equal true
    end
  end

  describe 'relations' do
    it 'has a list of votes' do
      album = works(:album)
      album.must_respond_to :votes
      album.votes.each do |vote|
        vote.must_be_kind_of Vote
      end
    end
  end
end
