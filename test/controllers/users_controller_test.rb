require "test_helper"

describe UsersController do
  let(:user) { users(:hana) }

  describe "login_form" do 
    it "can get the login page" do 
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do 
    it "will login a returning user" do 
      user_data = {
        user: {
          username: user.username,
        },
      }

      expect {
        post login_path, params: user_data
      }.wont_change "User.count"

      expect(session[:user_id]).must_equal user.id
      expect(flash[:success]).must_equal "Successfully logged in as an existing user #{user.username}"
    end

    it "will create new user" do 
      user_data = {
        user: {
          username: "new user",
        },
      }

      expect {
        post login_path, params: user_data
      }.must_change "User.count", +1

      expect(User.last.username).must_equal "new user"
      expect(flash[:success]).must_equal "Successfully logged in as a new user #{User.last.username}"
    end
  end

  # describe "current" do 
  #   it "will respond with success if a user is logged in" do 
  #     perform_login
  #     get current_user_path
  #     must_respond_with :success 
  #   end
  # end

  describe "logout" do 
    it "sets session id to nil" do 
      user = perform_login 
      expect(session[:user_id]).must_equal user.id 

      post logout_path
      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "Successfully logged out"
    end
  end
end
