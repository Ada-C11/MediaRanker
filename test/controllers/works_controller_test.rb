require "test_helper"

describe WorksController do
  describe "index" do
    it "should get index" do
      # Action
      get works_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing, valid work" do
      # Arrange
      valid_work_id = works(:book_1).id

      # Act
      get work_path(valid_work_id)

      # Assert
      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid book" do

      # Arrange
      album = works(:album_1)
      invalid_album_id = album.id
      album.destroy

      # Act
      get work_path(invalid_album_id)

      # Assert
      must_respond_with :redirect
      expect(flash[:error]).must_equal "unknown media"
    end
  end

  describe "create" do
    before do
      @input_title = "Good album"
      @input_category = "album"
      @input_creator = "Good singer"
      @input_publication_year = 2019
      @input_description = "A good album"
    end
    it "will save a new work and redirect if given valid inputs" do

      # Arrange
      test_input = {
        work: {
          title: @input_title,
          category: @input_category,
          creator: @input_creator,
          publication_year: @input_publication_year,
          description: @input_description,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.must_change "Work.count", 1

      # Assert
      new_work = Work.find_by(title: @input_title)
      expect(new_work).wont_be_nil
      expect(new_work.title).must_equal @input_title
      expect(new_work.category).must_equal @input_category
      expect(new_work.creator).must_equal @input_creator
      expect(new_work.publication_year).must_equal @input_publication_year
      expect(new_work.description).must_equal @input_description

      must_respond_with :redirect
    end

    it "will return a 400 with an invalid book" do

      # Arrange
      test_input = {
        "work": {
          title: "",
          category: @input_category,
          creator: @input_creator,
          publication_year: @input_publication_year,
          description: @input_description,
        },
      }

      # Act
      expect {
        post works_path, params: test_input
      }.wont_change "Work.count"
      # .must_change "Book.count", 0

      # Assert
      must_respond_with :bad_request
    end
  end
end
