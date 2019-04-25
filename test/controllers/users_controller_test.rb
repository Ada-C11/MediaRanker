require "test_helper"

describe UsersController do
  describe "login_form" do 
    it "displays the login#show page" do
      get login_path

      must_respond_with :ok
    end
  end

  describe "log_in" do 
    user_data = {
      user: {
        username: "First User"
      }
    }

    it "allows a user to login " do 
      post login_path, params: user_data

      must_respond_with :success
    end
  end
end
