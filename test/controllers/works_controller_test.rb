require "test_helper"

describe WorksController do
  let(:work) {
    Work.create(
      category: "book",
      title: "the witching hour",
      creator: "anne rice",
      publication_year: Date.strptime("1989", "%Y"),
      description: "witch coven in nola",
    )
  }

  let(:work_hash) {
    {
      category: "book",
      title: "the sorcerors stone",
      creator: "jk rowling",
      publication_year: "1998",
      description: "harrys first year at hogwarts",
    }
  }

  describe "index" do
    it "can get the index path" do
      get works_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "returns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    it "creates work" do
      expect {
        post works_path, params: { work: work_hash }
      }.must_change "Work.count"

      must_redirect_to works_path(Work.last)
    end
  end

  describe "edit" do
    it "can edit an existing work" do
      get edit_work_path(work.id)
      must_respond_with :success
    end
  end

  describe "update" do
    it "updates work" do
      patch work_path(work.id), params: { work: work_hash }
      must_redirect_to works_path(work)
    end
  end

  describe "show" do
    it "can get a valid work" do
      get works_path(work.id)
      must_respond_with :success
    end
  end

  describe "destroy" do
    it "destroys the work from the database" do
      delete work_path(work)

      must_respond_with :redirect
      must_redirect_to works_path

      after_title = Work.find_by(title: work.title)
      expect(after_title).must_be_nil
    end
  end

  describe "vote" do
    it "must be logged in to vote" do
      #skip
    end

    it "makes it so a user can only vote once" do
      #skip
    end
  end

  describe "homepage" do
    it "displays a homepage" do
      #skip
    end
  end

  describe "current_user" do
    it "is the current user" do
      #skip
    end
  end

  describe "work_params" do
    it "makes sure all params are covered" do
      #skip
    end
  end
end
