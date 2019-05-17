require "test_helper"

describe UsersController do
  describe "login" do
    it "can log in a user" do
    
      user = perform_login

      expect(session[:user_id]).must_equal user.id
      must_redirect_to root_path
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
