require "test_helper"
require "pry"
describe WorksController do
  describe "paths" do
    it "should get homepage from root" do
      get root_path

      must_respond_with :success
    end
    it "should get index" do
      # Action
      get works_path
      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show path" do
      valid_work_id = works(:book1).id
      get work_path(valid_work_id)
      must_respond_with :success
    end

    it "will redirect with invalid id" do
      get work_path(-5)

      must_respond_with :redirect
    end
  end

  describe "new" do
    it "new" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "creates a new work" do

      # Arrange
      work_data = {
        work: {
          category: "book",
          title: "Between the World and Me",
          creator: "Ta-Nehisi Coates",
          publication_year: 2015,
          description: "Letter to the author's teenage son.",
        },
      }
      # Act
      expect {
        post works_path, params: work_data
      }.must_change "Work.count", 1

      # Assert
      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
  describe "destroy" do
    it "can delete a book" do
      # Arrange - Create a work
      new_work = Work.create(category: "Book", title: "The Martian", creator: "Creator", publication_year: "Publication Year", description: "Description")

      expect {

        # Act
        delete work_path(new_work.id)

        # Assert
      }.must_change "Work.count", -1

      must_respond_with :redirect
      must_redirect_to works_path
    end
  end
end
