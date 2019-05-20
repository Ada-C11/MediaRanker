require "test_helper"

describe WorksController do
  describe "index" do
    it "can get index" do
      # Act
      get works_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid work" do

      # Act
      get work_path(two.id)

      # Assert
      must_respond_with :success
    end
  end
end
