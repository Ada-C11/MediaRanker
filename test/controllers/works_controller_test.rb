require "test_helper"

describe WorksController do
  describe "index" do
    it "can get the index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the details page" do
      work = works(:custom1)
      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect if given an invalid work ID" do
      get work_path(-1)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "retruns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates a new work" do
      work_data = {
        work: {
          title: "new title",
          category: "album",
          creator: "new creator",
          publication_year: 1989,
          description: "new description",
        },
      }

      expect {
        post works_path, params: work_data
      }.must_change "Work.count", +1

      must_respond_with :redirect
      must_redirect_to works_path

      check_flash

      work = Work.last
      expect(work.title).must_equal work_data[:work][:title]
      expect(work.publication_year).must_equal work_data[:work][:publication_year]
    end
  end

  describe "edit" do
    it "can get the edit page for an existing work" do
      work = Work.first
      get edit_work_path(work.id)
      must_respond_with :success
    end

    it "will respond with a redirect when attempting to edit a nonexistent work" do
      get edit_work_path(-1)
      must_redirect_to works_path
    end
  end

  describe "update" do
    let(:work_data) {
      {
        work: {
          publication_year: 2234,
        },
      }
    }
    it "changes the data on the model" do
      work = Work.first

      patch work_path(work), params: work_data

      must_respond_with :redirect
      must_redirect_to work_path(work)

      check_flash

      work.reload
      expect(work.publication_year).must_equal(work_data[:work][:publication_year])
    end

    it "responds with NOT FOUND for a fake book" do
      patch work_path(-1), params: work_data
      must_respond_with :not_found
    end

    it "responds with BAD REQUEST for bad data" do
      skip
      work = Work.first
      work_data[:work][:publication_year] = ""

      work.assign_attributes(work_data[:work])
      expect(work).wont_be :valid?
      work.reload

      patch work_path(work), params: work_data

      must_respond_with :bad_request

      check_flash(:error)
    end
  end

  describe "destroy" do
    it "removes the work from the database" do
      work_to_delete = Work.first
      expect {
        delete work_path(work_to_delete)
      }.must_change "Work.count", -1
      must_respond_with :redirect
      must_redirect_to works_path

      check_flash
      # check_flash(:error)

      after_delete_work = Work.find_by(id: work_to_delete.id)
      expect(after_delete_work).must_be_nil
    end
  end
end

#validate things? use fixtures or let?
