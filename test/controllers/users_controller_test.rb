require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
  end

  describe "new" do
  end

  describe "create" do
  end

  describe "edit" do
  end

  describe "update" do
  end

  describe "destroy" do
  end

  describe "login" do
    # I am going to reserve testing the different behaviors (between existing user or new user) for this set of tests, rather than in current
  end

  describe "current" do
    it "responds with success if a user is logged in" do
      logged_in_user = perform_login

      get current_user_path

      must_respond_with :success

      expect(session[:user_id]).must_equal logged_in_user.id
    end

    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
end
