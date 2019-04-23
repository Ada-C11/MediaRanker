require "test_helper"

describe WorksController do
  it "should get index" do
    get works_path

    must_respond_with :success
  end

  describe "show" do
    it "should be able to show an existing, valid work" do
      valid_work_id = works(:album).id

      get work_path(valid_work_id)

      must_respond_with :success
    end

    it "should redirect to the works index page when given an invalid work id" do
      work = works(:album)
      invalid_work_id = work.id
      work.destroy

      get work_path(invalid_work_id)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "can get the new work page" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can save a new driver" do
      work_hash = {
        work: {
          category: "book",
          title: "new book",
          creator: "new author",
          publication_year: 2019,
          description: "riveting new book!",
        },
      }

      expect { post works_path, params: work_hash }.must_change "Work.count", 1
    end
  end

  it "should get edit" do
    # get works_edit_url
    # value(response).must_be :success?
  end

  it "should get update" do
    # get works_update_url
    # value(response).must_be :success?
  end

  it "should get destroy" do
    # get works_destroy_url
    # value(response).must_be :success?
  end
end
