require "test_helper"

describe UsersController do
  describe "index" do
    it "can get the index page" do

      # Act
      get users_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the user detail page" do

      # Act
      get user_path(User.first.id)

      # Assert
      must_respond_with :success
    end

    it "shows a 404 if user isn't found" do

      # Act
      get user_path("FAKE")

      # Assert
      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "can get the login form page" do

      # Act
      get login_path

      # Assert
      must_respond_with :success
    end
  end

  describe "login" do
    it "will log in a user" do
      user_params = {
        user: {
          username: "panicpixels",
        },
      }

      post login_path, params: user_params

      test_user = User.find_by(username: user_params[:user][:username])

      expect(session[:user_id]).must_equal test_user.id
    end
  end

  describe "logout" do
    it "will log out a user" do
      user_params = {
        user: {
          username: "panicpixels",
        },
      }

      post login_path, params: user_params

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
