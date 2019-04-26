require "test_helper"

describe UsersController do
  describe 'login_form' do
    # 200 ok
  end 

  describe 'login' do 
    # 200 ok
    # user is the user 
    # redirects to root path

    # returns error for empty string 
      how to 
  end 

  describe 'logout' do
    # session user_id should be nil
    # redirects to root path
  end 

 
  describe "current" do
    it "responds with 200 OK for a logged-in user" do
      # Arrange
      user_data = {
        user: {
          username: "hello",
        },
      }

      post login_path(params: user_data)

      # Act
      get current_user_path

      # Assert
      must_respond_with :ok
    end
  end
end
