require "test_helper"

describe "UsersController" do
  describe "login_form" do
    it "can render the login form" do
      get login_path
      must_respond_with :ok
    end
  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
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
  end
end
