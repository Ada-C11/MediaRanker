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

  describe 'edit' do
    it 'can get the edit page for an existing work' do
      category = Category.create!(name: 'album')
      work = Work.create!(title: 'Lemonade', creator: 'Beyonce', publication_year: 2015, category_id: category.id)
      get edit_work_path(work.id)

      must_respond_with :success
    end

    it 'will respond with redirect when attempting to edit a nonexistant work' do
      # Act
      get edit_work_path(-1)

      # Assert
      must_respond_with :not_found
    end
  end

  describe 'update' do
    it ' changes the data on the model' do
      category = Category.create!(name: 'album')
      work = Work.create!(title: 'Lemonade', creator: 'Beyonce', publication_year: 2015, category_id: category.id)

      work_data = {
        work: {
          publication_year: 2016
        }
      }

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      expect(work.publication_year).must_equal(work_data[:work][:publication_year])
    end
  end

  describe 'new' do
    it 'returns status code 200' do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe 'create' do
    it 'creates a new work' do
      category = Category.create!(name: 'album')
      work_data = {
        work: {
          title: 'I Am... Sasha Fierce',
          creator: 'Beyonce',
          category_id: category.id,
          publication_year: 2008
        }
      }

      expect do
        post works_path, params: work_data
      end.must_change 'Work.count', +1

      must_respond_with :redirect

      work = Work.last
      expect(work.title).must_equal(work_data[:work][:title])
      expect(work.category_id).must_equal(work_data[:work][:category_id])
    end
  end

  describe 'destroy' do
    it 'removes the work from the database' do
      category = Category.create!(name: 'album')
      work = Work.create!(title: 'Lemonade', creator: 'Beyonce', publication_year: 2015, category_id: category.id)

      expect do
        delete work_path(work)
      end.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to works_path

      after_work = Work.find_by(id: work.id)
      expect(after_work).must_be_nil
    end

    it "returns a 404 if the work doesn't exist" do
      work_id = 12_344_444

      expect(Work.find_by(id: work_id)).must_be_nil

      expect do
        delete work_path(work_id)
      end.wont_change 'Work.count'

      must_respond_with :not_found
    end
  end
end
