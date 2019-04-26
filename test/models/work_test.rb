require 'test_helper'

describe Work do
  describe 'validations' do
    before do
      category = Category.create(name: 'movie')
      @work = Work.new(title: 'Star Trek', creator: 'Gene Roddenberry', publication_year: 2009, category_id: category.id)
    end

    it 'is valid when all fields are present' do
      result = @work.valid?

      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      @work.title = nil

      result = @work.valid?

      expect(result).must_equal false
    end
  end
end
