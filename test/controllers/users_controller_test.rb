require "test_helper"

describe UsersController do
  describe "login form" do
    it "renders without crashing" do
      get login_path
      must_respond_with :ok
    end
  end
  describe "login" do
    it "logs in the user" do
      perform_login
      get current_user_path
      must_respond_with :ok
    end
  end

  describe "logout" do
    it "can logout the user" do
      perform_login
      post logout_path
      must_respond_with :redirect

      expect(session[:user_id]).must_equal nil
    end
  end

  describe "current" do
    # before do
    #   perform_login
    # end
    it "returns 200 OK for a logged-in user" do
      perform_login
      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end
    it "redirect if no one is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
end
