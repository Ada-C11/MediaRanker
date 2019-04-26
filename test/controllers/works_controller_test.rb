require "test_helper"

describe "WorksController" do
  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get works_path

      # Assert
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

  describe "new" do
    it "retruns status code 200" do
      get new_work_path
      must_respond_with :ok
    end
  end
end
