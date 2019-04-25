require "test_helper"
# require "pry"

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
      user = User.first
      login_data = {
        user: {
          username: user.username,
        },
      }
      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_equal "Successfully logged in as existing user #{user.username}"
    end

    it "can log in a new user" do
      login_data = {
        user: {
          username: "code-newbie-hero",
        },
      }
      post login_path, params: login_data

      new_user = User.find_by(username: login_data[:user][:username])

      expect(session[:user_id]).must_equal new_user.id
      expect(flash[:success]).must_equal "Successfully created new user #{new_user.username} with ID #{new_user.id}"
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

  describe "logout" do
    it "can log out a current user" do
      user = User.first
      login_data = {
        user: {
          username: user.username,
        },
      }
      post login_path, params: login_data

      post logout_path, params: login_data

      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "Successfully logged out"
      must_respond_with :redirect
    end
  end
end
