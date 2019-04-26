require "test_helper"

describe UsersController do
  describe "login_form" do 
    it "displays the login#show page" do
      get login_path

      must_respond_with :ok
    end
  end

  describe "log_in" do 
    
    it "allows a user to login " do 
      user = User.first
      login_data = {
        user: {
          username: user.username,
        },
      }
      post login_path, params: login_data
    
        # Verify the user ID was saved - if that didn't work, this test is invalid
      expect(session[:user_id]).must_equal user.id
      expect(flash[:status]).must_equal :success
      must_redirect_to root_path
    end
  end
end
