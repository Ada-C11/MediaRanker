require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "successfully adds user information to session hash" do
      logged_in_user = perform_login
      get current_user_path
      must_respond_with :success
    end
    it "responds with a redirect if username is invalid" do
      login_data = {
        name: "",
      }
      post login_path, params: login_data
      must_respond_with :redirect
    end
  end

  describe "current" do
    it "responds with success if a user is logged in" do
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
    it "reponds with a redirect and sets session user id to nil" do
      logged_in_user = perform_login
      post logout_path
      must_respond_with :redirect
    end
  end
end
