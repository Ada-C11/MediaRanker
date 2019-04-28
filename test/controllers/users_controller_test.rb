require "test_helper"

describe UsersController do
  describe "login-form" do
    it "can get the login-form" do
      get login_path
      must_respond_with :success
    end
  end
  describe "login" do
    it "allows a new user to log in and create adds the user into the database" do
      log_in_data = {
        user: {
          username: "newuser",
        },
      }

      expect {
        post login_path, params: log_in_data
      }.must_change "User.count", 1

      must_respond_with :redirect
      must_redirect_to root_path

      expect(flash[:alert]).must_equal "#{log_in_data[:user][:username]} logged in!"
    end

    it "allows an existing user to log in" do
      expect {
        perform_login(users(:one))
      }.wont_change "User.count"

      must_respond_with :redirect
      must_redirect_to root_path

      expect(flash[:alert]).must_equal "#{users(:one).username} logged in!"
    end

    it "gives flash error with invalid user data trying to log in" do
      log_in_data = {
        user: {
          username: "",
        },
      }

      expect {
        post login_path, params: log_in_data
      }.wont_change "User.count"

      must_respond_with :redirect
      must_redirect_to root_path

      expect(flash[:error]).must_equal "Unable to log in!"
    end
  end

  describe "logout" do
    it "allows user to log out" do
      user = User.first
      perform_login(user)
      post logout_path

      must_respond_with :redirect
      must_redirect_to root_path
      expect(session[:user_id]).must_equal nil
    end
  end
end
