require "test_helper"

describe UsersController do
  describe "current" do
    it "responds with 200 OK for a logged-in user" do
      # Arrange
      username = "adele"
      post login_path(username)

      # Act
      get current_user_path

      # Assert
      must_respond_with :ok
    end
  end
end
