require "test_helper"

describe "UsersController" do
  describe "login_form" do
    it "can render the login form" do
      get login_path
      must_respond_with :ok
    end
  end

  describe "login" do
    it "logs in an user" do
      new_user = User.create(username: "newuser")

      login_data = {
        user: {
          username: new_user.username,
        },
      }

      post login_path, params: login_data
      expect(session[:user_id]).must_equal new_user.id
    end
  end

  describe "login" do
    it "logs out an user" do
      user = User.create(username: "logmeout")

      login_data = {
        user: {
          username: user.username,
        },
      }

      post login_path, params: login_data
      expect(session[:user_id]).must_equal user.id

      post logout_path
      expect(session[:user_id]).must_be_nil
    end
  end
end
