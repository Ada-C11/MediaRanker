require "test_helper"

describe UsersController do
  describe "index" do
    it "can get index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "shows a user that exists" do
      get user_path(users(:niv).id)
      must_respond_with :ok
    end

    it "returns a 404 status code if the work doesn't exist" do
      get user_path(-1)
      must_respond_with :not_found
    end

  end

  describe "login_form" do
    it "can get to the new login form" do
      get login_path
      must_respond_with :ok
    end
  end

  describe "login" do
    it "logs in successfully as a new user" do
      user_data = {
        user: {
          username: "new user"
        }
      }

      expect {
        post login_path, params: user_data
      }.must_change "User.count", +1

      must_respond_with :redirect
    end

    it "logs in successfully as a returning user" do
      user_data = {
        user: {
          username: "niv"
        }
      }
      expect {
        post login_path, params: user_data
      }.wont_change "User.count"

      must_respond_with :redirect
    end

    it "does not log in for no username sent in" do
      user_data = {
        user: {
          username: ""
        }
      }
      expect {
        post login_path, params: user_data
      }.wont_change "User.count"

      must_respond_with :redirect
    end

  end

  describe "logout" do
    it "logs out successfully for a logged in user" do
      perform_login
      post logout_path
      expect(session[:user_id]).must_be_nil
    end

    it "logs out successfully for a no user logged in" do
      post logout_path
      expect(session[:user_id]).must_be_nil
    end

  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      perform_login
      get current_user_path
      must_respond_with :success
    end
  end

end
