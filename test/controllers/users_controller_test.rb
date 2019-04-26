require "test_helper"

describe UsersController do
  describe "login form" do
    it "renders without crashing" do
      get login_path
      must_respond_with :ok
    end
  end
  describe "login" do
    # it "can log in a user" do
    #   user_data = {
    #    user: {
    #      username: "test user"
    #    }

    #    #post login_path, params: user_data

    #     must_respond_with :redirect
    #     must_redirect_to works_path

    #     expect(session[:username]).must_equal user_data[:user][username]
    #   end

  end
end
