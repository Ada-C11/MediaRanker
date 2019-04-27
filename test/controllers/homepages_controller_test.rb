require "test_helper"

describe HomepagesController do
  describe "index" do
    it "renders without crashing" do
      get works_path
      must_respond_with :ok
    end
    it "renders even if there are zero works" do
      # Arrange
      Work.destroy_all

      # Act
      get works_path

      # Assert
      must_respond_with :ok
    end
  end
end
