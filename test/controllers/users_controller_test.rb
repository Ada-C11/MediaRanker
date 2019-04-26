require "test_helper"

describe UsersController do
  describe "login" do
    it "can log in a user" do
      # Act
      user = perform_login

      # Assert
      expect(session[:user_id]).must_equal user.id
      must_redirect_to root_path
    end
  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      # Arrange
      perform_login

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end

    it "respond with redirect if user is not logged in" do
      # Arrange
      # no user logged in / could log in and then log out post logout_path
      # Act
      get current_user_path

      # Assert
      must_respond_with :redirect
    end
  end

  describe "logout" do
    it "session id is nil after user logs out" do
      user = perform_login

      expect(session[:user_id]).must_equal user.id

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end

  #logout

end
