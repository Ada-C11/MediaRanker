require "test_helper"

describe UsersController do
  describe "index" do
    it "can render" do
      get users_path

      must_respond_with :ok
    end

    it "renders even if there are zero users" do
      User.destroy_all

      get users_path

      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the user doesn't exist" do
      user_id = "FAKE ID"

      get user_path(user_id)

      must_respond_with :not_found
    end

    it "works for a User instance that exists" do
      user = users(:one)
      
      get user_path(user)

      must_respond_with :ok
    end
  end

  describe "login form" do
    it "can render login_form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "can login user" do
      expect(perform_login).must_equal users(:one)
    end

    it "can find an existing user and flash success message" do
      user_input = {
        "user": {
          username: users(:one).username,
        },
      }

      expect {
        post login_path, params: user_input
      }.wont_change "User.count"

      expect(flash[:message]).must_equal "Successfully logged in as user #{users(:one).username}"
      must_respond_with :redirect
    end

    it "can create a new user and flash success message" do
      user_input = {
        "user": {
          username: "newuser"
        },
      }

      expect {
        post login_path, params: user_input
      }.must_change "User.count", +1

      expect(flash[:message]).must_equal "Successfully logged in as user newuser"
      must_respond_with :redirect
    end
  end
    
  describe "logout" do
    it "can end the session" do
      perform_login
      post logout_path
      expect(session[:user_id]).must_be_nil
    end

    it "can flash success message" do
      perform_login
      post logout_path
      expect(flash[:message]).must_equal "Successfully logged out"
    end

    it "can redirect" do
      perform_login
      post logout_path
      must_respond_with :redirect
    end
  end
end