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

      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :redirect
    end
  end

  describe "index" do
    it "can get the index" do
      get users_path
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the details page" do
      user = users(:custom1)
      expect(user.username).must_equal "cyndilopez6"
      get user_path(user.id)
      must_respond_with :success
    end

    it "will redirect if given an invalid user id" do
      get user_path(-1)

      must_respond_with :redirect
    end
  end
end
