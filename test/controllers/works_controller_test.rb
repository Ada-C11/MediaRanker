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
end
