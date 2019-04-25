require "test_helper"

describe UsersController do
  describe "login" do
    it "will create a new user and return new user flash message if user is new" do
      post login_path, params: {
                         user: {
                           username: "test name",
                         },
                       }

      expect(User.last.username).must_equal "test name"
      expect(flash[:success]).must_equal "Successfully logged in as a new user!"
      must_respond_with :redirect
    end

    it "will find existing user and return a flash returner message" do
      user = perform_login
      expect(flash[:success]).must_equal "Successfully logged in as a returning user!"
    end
  end

  describe "current" do
    it "will respond with success if a user is logged in" do
      perform_login
      get current_user_path
      must_respond_with :success
    end

    it "will respond with redirect and flash if no user was logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end

  describe "logout" do
    it "sets session id to nil and redirects to root path" do
      user = perform_login
      expect(session[:user_id]).must_equal user.id

      post logout_path
      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "You have successfully logged out!"
    end
  end
end
