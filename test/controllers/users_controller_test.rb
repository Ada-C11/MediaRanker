require "test_helper"

describe UsersController do
  let(:user) { users(:one) }

  it "should get login form" do
    get login_path
    must_respond_with :success
  end

  describe "Users#log in" do
    it "should display flash success for existing user" do
      test_input = {
        "user": {
          username: user.username,
        },
      }

      expect {
        post login_path, params: test_input
      }.wont_change "User.count"

      expect(flash[:success]).must_equal "Successfully logged in as #{user.username}"
    end
  end

  describe "index action" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show action" do
    it "should get current user page" do
      get user_path(user.id)
      must_respond_with :success
    end

    it "should respond with flash message (invalid user) given an invalid user id" do
      user_id = user.id
      user.destroy
      get user_path(user_id)
      expect(flash[:error]).must_equal "Invalid user"
      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "should log a user out" do
      perform_login

      post logout_path
      expect(session[:user_id]).must_be_nil

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
