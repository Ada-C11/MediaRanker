require "test_helper"

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
    it "should get new" do
      get new_work_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "will save a new book and redirect if given valid inputs" do

      # Arrange
      input_category = "Book"
      input_title = "Practical Object Oriented Programming in Ruby"
      input_creator = "Sandi Metz"
      input_publication_year = 2012
      input_description = "A look at how to design object-oriented systems"
      test_input = {
        "book": {
          category: input_category,
          title: input_title,
          creator: input_creator,
          publication_year: input_publication_year,
          description: input_description,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: input_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal input_title
      expect(new_book.creator).must_equal input_creator
      expect(new_book.description).must_equal input_description

      must_respond_with :redirect
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
