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
      get work_path(-1)

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

    it "will return a 400 with an invalid work" do

      # Arrange
      input_category = "album"
      input_title = ""

      test_input = {
        "work": {
          category: input_category,
          title: input_title,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.wont_change "Work.count"

      # Assert
      must_respond_with :bad_request
    end
  end

  describe "edit" do
    it "should get edit" do
      work = works(:album)

      get edit_work_path(work.id)

      must_respond_with :success
    end

    it "will respond with bad request attempting to edit a nonexistant work" do
      get edit_work_path(-1)

      must_redirect_to works_path
    end
  end

  describe "update" do
    it "should get update" do
      work = works(:album)

      update_hash = {
        work: {
          category: work.category,
          title: work.title,
          creator: "Pfeiffer",
          publication_year: 2020,
          description: "Crazy dog album",
        },
      }
      patch work_path(work.id, params: update_hash)
      work.reload

      expect(work.creator).must_equal "Pfeiffer"
    end

    it "cannot update book without valid fields" do
      work = works(:album)

      update_hash = {
        work: {
          category: nil,
          title: "title",
          creator: "Pfeiffer",
          publication_year: 2020,
          description: "Crazy dog album",
        },
      }

      expect { patch work_path(work.id, params: update_hash) }.wont_change "Work.count"

      must_respond_with :bad_request
    end
  end

  describe "destroy" do
    it "can delete a work" do
      expect { delete work_path(works(:album).id) }.must_change "Work.count", -1
    end

    it "redirects to the index page if the work is not found" do
      delete work_path(-1)

      must_respond_with :not_found
    end
  end
end
