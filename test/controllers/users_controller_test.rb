require "test_helper"

describe UsersController do
  describe "current" do
    it "returns 200 OK for a logged-in user" do
      # Arrange
      perform_login
    
      # Act
      get current_user_path
    
      # Assert
      must_respond_with :success
    end
  end

  describe "logout" do
    it "verifies session id is nil after logout" do
      user = perform_login

      expect(session[:user_id]).must_equal user.id

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
