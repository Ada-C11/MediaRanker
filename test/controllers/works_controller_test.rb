require "test_helper"

describe WorksController do
  let(:work) do
    Work.create category: 'album', title: 'this great world',
    creator: 'jonny', publication_year: 1995, description: 'A great song about a new work', votes: 3
  end

  describe "index" do
    it 'can get the index path' do
      get works_path

      must_respond_with :success
    end

    it "works with no works" do
      work.destroy
      get works_path
      must_respond_with :success
    end
  end

  describe "show" do
    it 'can get a valid work' do
      get works_path(work.id)

      must_respond_with :success
    end
  end

  describe "edit" do
    it 'can get the edit page for an existing work' do
      get edit_work_path(work)

      must_respond_with :success
    end
  end

  describe "update" do
    it 'can update an existing work' do
      work = Work.create!(category: 'album', title: 'this great world',
    creator: 'jonny', publication_year: 1995, description: 'A great song about a new work', votes: 3)
      work_hash = {
        work: {
          category: 'album', 
          title: 'this great world',
          creator: 'jonny', 
          publication_year: 1995, 
          description: 'A great song about a new work', 
          votes: 3
        }
      }
      patch work_path(work), params: work_hash

      must_respond_with :redirect
      must_redirect_to work_path(work)

      work.reload
      expect(work.category).must_equal(work_hash[:work][:category])
    end

    it "flashes an error if the work does not exist" do
      work_id = 123456789

      patch work_path(work_id), params: {}

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: #{work_id}"
    end
  end

  describe "new" do
    it 'can get the new work page' do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it 'can create a new work' do
      work_hash = {
        work: {
          category: 'album', 
          title: 'this great world',
          creator: 'jonny', 
          publication_year: 1995, 
          description: 'A great song about a new work', 
          votes: 3
        }
      }

      expect do
        post works_path, params: work_hash
      end.must_change 'Work.count', 1

      new_work = Work.find_by(id: work_hash[:work][:id])
      expect(new_work.id).must_equal work_hash[:work][:id]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end
  end

  describe "destroy" do
    it 'removes the work from the database' do
      work = Work.create!(category: 'album', title: 'this great world',
    creator: 'jonny', publication_year: 1995, description: 'A great song about a new work', votes: 3)

      expect do
        delete work_path(work)
      end.must_change 'Work.count', -1

      must_respond_with :redirect
      must_redirect_to works_path

      after_work = Work.find_by(id: work.id)
      expect(after_work).must_be_nil
    end

    it "flashes an error if the work does not exist" do
      work_id = 123456789

      expect {
        delete work_path(work_id)
      }.wont_change "Work.count"

      must_respond_with :redirect
      expect(flash[:error]).must_equal "Could not find work with id: #{work_id}"
    end
  end
end
