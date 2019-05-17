require "test_helper"

describe WorksController do
  it 'can list all media' do
    get works_path
    must_respond_with :success
  end

  it 'renders page with zero works' do
    Work.destroy_all
    get works_path
    must_respond_with :ok
  end

  it 'returns a work that exists' do
    work = Work.create!(title: 'Some Awsome Album')
    get work_path(work.id)
    must_respond_with :ok
  end

  describe "new" do
    it 'returns status code 200' do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe 'create' do
    it 'create a new work' do
      work_data = {
        work: {
          title: 'New Title',
        }
      }

      expect {
        post works_path, params: work_data
    }.must_change 'Work.count', +1

    must_respond_with :redirect
    must_redirect_to works_path
    
    end
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

  describe "destroy" do
    it "removes work from database" do
      work = Work.create!(title: 'Deletable Title')
      expect {
        delete work_path(work)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path

      deleted_work = Work.find_by(id: work.id)
      expect(deleted_work).must_be_nil
    end

    it "returns a 404 if the work does not exist" do
      work_id = 123_456_789

      expect(Work.find_by(id: work_id)).must_be_nil

      expect {
        delete work_path(work_id)
      }.wont_change "Work.count"

      must_respond_with :not_found
    end
  end
end
