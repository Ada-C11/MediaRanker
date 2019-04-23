require "test_helper"

describe WorksController do
  let (:work) {
    works(:movie)
  }

  describe "index" do
    it "should get index" do
      get works_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do
      get work_path(work.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work" do
      invalid_id = -1
      get work_path(invalid_id)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new task page" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new work" do
      work_hash = {
        work: {
          category: "book",
          title: "A Song of Ice and Fire",
          creator: "George R. R. Martin",
          publication_year: 1996,
          description: "epic fantasy novel",
        },
      }

      expect {
        post works_path, params: work_hash
      }.must_change "Work.count", 1

      new_work = Work.find_by(title: work_hash[:work][:title])
      expect(new_work.category).must_equal work_hash[:work][:category]
      expect(new_work.publication_year).must_equal work_hash[:work][:publication_year]
      expect(new_work.description).must_equal work_hash[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(new_work.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing work" do
      get edit_work_path(work.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistent work" do
      invalid_id = "Not a valid id!"

      get edit_work_path(invalid_id)

      must_respond_with :redirect
    end
  end

  describe "update" do
    it "can update an existing work" do
      work_change = {
        work: {
          publication_year: 2000,
          description: "this is a new description!",
        },
      }

      patch work_path(work.id), params: work_change

      edited_work = Work.find_by(id: work.id)
      expect(edited_work.publication_year).must_equal work_change[:work][:publication_year]
      expect(edited_work.description).must_equal work_change[:work][:description]

      must_respond_with :redirect
      must_redirect_to work_path(work.id)
    end

    it "will redirect to the works index page if given an invalid id" do
      invalid_work_id = -1
      patch work_path(invalid_work_id)
      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end
