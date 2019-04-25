require "test_helper"

describe UsersController do
  describe "login" do
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

    # it "respond with redirect if user is not logged in" do
    #   # Arrange
    #   # no user logged in / could log in and then log out post logout_path
    #   # Act
    #   get current_user_path

    #   # Assert
    #   must_respond_with :redirect
    # end
  end

  #current

  #logout

end
