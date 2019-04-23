require "test_helper"

describe WorksController do
  before do
    @work = Work.create(category: "book", title: "test book", creator: "test creator", publication_date: 1996, description: "a good test item")
  end
  describe "index" do
    it "renders without crashing" do
      get works_path
      must_respond_with :ok
    end
    it "renders even if there are zero books" do
      # Arrange
      Work.destroy_all

      # Act
      get works_path

      # Assert
      must_respond_with :ok
    end
  end
  describe "show" do
    it "returns a 404 status code if the works doesn't exist" do
      # TODO come back to this
      work_id = 12345

      get work_path(work_id)

      must_respond_with :not_found
    end
    it "works for a work that exists" do
      get work_path(@work.id)

      # Assert
      must_respond_with :ok
    end
  end
  describe "edit" do
    it "responds with OK for a real real" do
      get edit_work_path(@work)
      must_respond_with :ok
    end

    it "responds with NOT FOUND for a fake work" do
      work_id = Work.last.id + 1
      get edit_work_path(work_id)
      must_respond_with :not_found
    end
  end
end
