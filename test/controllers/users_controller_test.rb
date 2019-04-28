require "test_helper"

describe UsersController do
  describe "index" do
    it "can get all users" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid user" do
      user = User.first
      get user_path(user.id)
      must_respond_with :success
    end

    it "gives a flash error message if the user is not found" do
      get user_path(-1)
      must_respond_with :redirect
      must_redirect_to users_path
      expect(flash[:error]).must_equal "User not found!"
    end
  end
  describe "login-form" do
    it "can get the login-form" do
      get login_path
      must_respond_with :success
    end
  end
  describe "login" do
    it "allows a new user to log in and adds the user into the database" do
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

      expect(flash[:alert]).must_equal "Successfully created new user #{log_in_data[:user][:username]}!"
    end

    it "allows an existing user to log in" do
      expect {
        perform_login(users(:one))
      }.wont_change "User.count"

      must_respond_with :redirect
      must_redirect_to root_path

      expect(flash[:alert]).must_equal "#{users(:one).username} logged in!"
    end

    it "gives flash error when user trying to log in with invalid username" do
      log_in_data = {
        user: {
          username: "",
        },
      }

      expect {
        post login_path, params: log_in_data
      }.wont_change "User.count"

      must_respond_with :bad_request

      expect(flash[:username]).must_equal ["can't be blank"]
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
