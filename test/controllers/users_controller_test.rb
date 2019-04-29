require "test_helper"

describe UsersController do
  describe "login" do
    it "logs in a user" do
    
     post login_path, params: {
        user: {
          username: "test",
        },
      }

      expect(User.last.username).must_equal "test"
      must_respond_with :redirect
    end
  end

  describe "logout" do
    it "verifies session id is nil after logout" do
      user = perform_login

      expect(session[:user_id]).must_equal user.id

      post logout_path

      expect(session[:user_id]).must_be_nil
    end
  end
end
