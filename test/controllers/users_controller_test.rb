require "test_helper"

describe UsersController do
  let (:user_one) {
    users(:user_one)
  }
  describe "login_form" do
    it "should get login form" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can log in an existing user" do
    end

    it "can log in a new user" do
    end
  end

  describe "current" do
    it "responds with success (200 OK) for a logged-in user" do
      user = User.first
      login_data = {
        user: {
          username: user.username,
        },
      }
      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :success
    end

    it "must redirect if no user is logged in" do
      get current_user_path

      expect(flash[:error]).must_equal "You must be logged in to see this page!"
      must_respond_with :redirect
    end
  end
end
