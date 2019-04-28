require "test_helper"

describe UsersController do
  describe "current" do
    it "responds with success if a user is logged in" do
      logged_in_user = perform_login

      get login_path

      must_respond_with :success
    end

    it "responds with a redirect if no user is logged in" do
      get user_path
      must_respond_with :redirect
    end
  end
end
