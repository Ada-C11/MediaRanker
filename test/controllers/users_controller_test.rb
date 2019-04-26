require "test_helper"

describe UsersController do
  describe "current" do
    it "gets the login path" do
      get login_path

      must_respond_with :success
    end

    it "returns 200 OK for a logged-in user" do
      user = users(:custom1)
      login_data = {
        user: {
          username: user.username,
        },
      }

      post login_path, params: login_data

      must_respond_with :redirect

      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :redirect
    end
  end
end
