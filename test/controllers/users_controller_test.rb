require "test_helper"
require "pry"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should be OK to show an existing user" do
      valid_user_id = users(:user12).id
      get user_path(valid_user_id)
      must_respond_with :success
    end

    it "should give a flash notice instead of showing a non-existant, invalid user" do
      user = users(:user1)
      invalid_user_id = user.id
      Vote.delete_all
      user.destroy
      get user_path(invalid_user_id)
      must_respond_with :redirect
      expect(flash[:error]).must_equal "Unknown user"
    end
  end

  describe "login" do
    it "successfully adds user information to session hash" do
      logged_in_user = perform_login
      get user_path(logged_in_user.id)
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

  describe "logout" do
    it "reponds with a redirect and sets session user id to nil" do
      logged_in_user = perform_login
      post logout_path
      expect(flash[:notice]).must_equal "Successfully logged out"
      must_respond_with :redirect
    end
  end
end
