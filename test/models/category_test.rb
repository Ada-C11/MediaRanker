require 'test_helper'

describe Category do
  describe 'validations' do
    it 'requires a category name' do
      category = Category.new
      category.valid?.must_equal false
      category.errors.messages.must_include :name
    end

    it 'rejects a category with the same name' do
      category = Category.new(name: 'album')
      result = category.save
      result.must_equal false
      category.errors.messages.must_include :name
    end
  end

  describe 'relations' do
    it 'has works' do
      album = categories(:album)
      album.must_respond_to :works
      album.works.each do |work|
        work.must_be_kind_of Work
      end
    end
  end
end
