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
end

#validate things? use fixtures or let?
