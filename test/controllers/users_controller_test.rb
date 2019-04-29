require "test_helper"

describe UsersController do
  describe "index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "login_form" do
    it "should get login form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "should get show" do
      get user_path(users(:chris).id)
      must_respond_with :success
    end

    it "will respond with 404 if the work is not found" do
      user = users(:dee)
      invalid_user_id = user.id
      user.votes.each { |vote| vote.destroy }
      user.destroy

      get user_path(invalid_user_id)
      must_respond_with :not_found
    end
  end

  describe "login" do
    it "can log in" do
      logged_in_user = perform_login

      expect(session[:user_id]).must_equal logged_in_user.id
    end
  end

  describe "logout" do
    it "can log out logged in user" do
      logged_in_user = perform_login

      expect(session[:user_id]).must_equal logged_in_user.id

      post logout_path

      expect(session[:user_id]).must_be_nil
    end

    it "can log out no logged in user" do
      post logout_path

      expect(session[:user_id]).must_be_nil
    end
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
