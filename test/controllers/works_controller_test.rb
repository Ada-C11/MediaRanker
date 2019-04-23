require 'test_helper'

describe WorksController do
  describe 'index' do
    it 'renders without crashing' do
      # Arrange
      category = Category.create!(name: 'album')
      Work.create!(title: 'Lemonade', creator: 'Beyonce', publication_year: 2015, category_id: category.id)

      # Act
      get works_path

      # Assert
      must_respond_with :ok
    end

    it 'renders even if there are zero works' do
      Work.destroy_all

      get works_path

      must_respond_with :ok
    end
  end

  describe 'show' do
    it "returns a 404 status code if the work doesn't exist" do
      work_id = 12_345

      get work_path(work_id)

      must_respond_with :not_found
    end

    it 'returns a work that exists' do
      category = Category.create!(name: 'album')
      work = Work.create!(title: 'Lemonade', creator: 'Beyonce', publication_year: 2015, category_id: category.id)

      get work_path(work.id)

      must_respond_with :ok
    end
  end
end
