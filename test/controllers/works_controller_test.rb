require "test_helper"

describe WorksController do
  it 'can list all media' do
    get works_path
    must_respond_with :success
  end

  it 'renders with zero works' do
    Work.destroy_all
    get works_path
    must_respond_with :ok
  end

  it 'returns a work that exists' do
    work = Work.create!(title: 'Some Awsome Album')
    get work_path(work.id)
    must_respond_with :ok
  end

  describe 'edit' do
    it 'can edit an existing work' do
      work = Work.create!(title: 'Some Awsome Album')
      get edit_work_path(work.id)
      must_respond_with :success
    end

    it 'will redirect if trying to edit invalid work' do
      get edit_work_path(-1)
      must_respond_with :not_found
    end
  end

  describe 'update' do
    it 'updates data on the model' do
      work = Work.create!(title: 'Old Title')
      work_data = {
        work: {
          title: 'New Title',
        }
      }

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      expect(work.title).must_equal(work_data[:work][:title])
    end
  end
end
