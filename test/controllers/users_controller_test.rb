require "test_helper"

describe UsersController do
  it "should get index" do
    get users_path

    must_respond_with :success
  end

  describe "login_form" do
    it "can get the login page" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can successfully log in a user" do
      user_params = {
        user: {
          username: users(:one).username,
        },
      }

      post login_path(user_params)

      must_redirect_to root_path
    end

    it "will redirect if invalid user" do
      user_params = {
        user: {
          username: nil,
        },
      }
      post login_path(user_params)

      expect(flash[:error]).must_equal "Unable to log in"
      must_redirect_to root_path
    end
  end

  describe "current" do
    it "responds with success if a user is logged in" do

      #perform_login found in test_helper.rb
      logged_in_user = perform_login

      get current_user_path

      must_respond_with :success
    end

    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end

  describe "logout" do
    it "can successfully log out a user" do
      logged_in_user = perform_login

      user_params = {
        user: {
          username: logged_in_user.username,
        },
      }

      post logout_path

      expect(flash[:notice]).must_include "Logged out"
    end
  end
end
