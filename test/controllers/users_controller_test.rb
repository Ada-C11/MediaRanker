require "test_helper"

describe UsersController do
  describe "login form" do
    it "renders without crashing" do
      get login_path
      must_respond_with :ok
    end
  end
  # describe "login" do
  #   it "can make a session with the user that logged in" do
  #     user_data = {
  #       user: {
  #         uesrname: "test user",
  #       },
  #     }
  #     test_user = User.new(user_data)
  #     perform_login(test_user)
  #     expect(session[:username]).must_equal "test user"
  #   end
  # end
  describe "current" do
    before do
      perform_login
    end
    it "returns 200 OK for a logged-in user" do
      # Arrange
      # perform_login

      # Act
      get current_user_path

      # Assert
      must_respond_with :success
    end
  end
end
