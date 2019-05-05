require "test_helper"

describe UsersController do
  describe "current" do
    # it "responds with success if a user is logged in" do
    #   new_user = User.create(username: "newuser")
    #   # Arrange
    #   # logged_in_user = perform_login

    #   # Act
    #   get current_user_path

    #   # Assert:
    #   must_respond_with :success
    # end

    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
end
