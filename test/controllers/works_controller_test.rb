require "test_helper"

describe WorksController do
  describe "index" do
    it "shows the index page" do
      get works_path
      must_respond_with :ok
    end
  end

  describe "new" do
    it "must load the page" do
      get new_work_path
      must_respond_with :ok
    end
  end

  describe "create" do
    let(:work_data) {
      {
        work: {
          title: "It",
          category: "book",
          creator: "Stephen King",
        },
      }
    }
    it "must create the work" do
      expect {
        post works_path(params: work_data)
      }.must_change "Work.count", 1

      work = Work.last
      expect(work.title).must_equal "It"
      check_flash
    end
  end

  describe "show" do
    it "must load the page with valid work ID" do
      work_id = Work.first.id
      get work_path(work_id)

      must_respond_with :ok
    end

    it "must redirect with invalid work ID" do
      get work_path(12345678)

      must_redirect_to root_path

      check_flash(:warning)
    end
  end

  describe "edit/update" do
    let(:work_data) {
      {
        work: {
          title: "It",
          category: "book",
          creator: "Stephen King",
        },
      }
    }

    it "must load the edit page" do
      get edit_work_path(Work.first)

      must_respond_with :ok
    end

    it "must redirect for invalid work id" do
      get edit_work_path(1234567)
      must_redirect_to root_path
      check_flash(:warning)
    end

    it "must update the work" do
      patch work_path(Work.first), params: work_data

      expect(Work.first.title).must_equal "It"
      check_flash
    end

    it "flashes a warning if invalid data is entered" do
      work_data[:work][:title] = nil
      patch work_path(Work.first), params: work_data

      check_flash(:warning)
    end
  end

  describe "destroy" do
    it "removes the work from the db" do
      expect {
        delete work_path(Work.first)
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path

      check_flash
    end

    it "redirects if the work is invalid, doesn't change the db" do
      expect {
        delete work_path(1234567)
      }.wont_change "Work.count"

      must_redirect_to root_path
    end

    it "destroys the work even if it has votes" do
      post upvote_path(Work.first)

      expect {
        delete work_path(Work.first)
      }.must_change "Work.count", -1
    end
  end
end
