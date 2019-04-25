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
end
