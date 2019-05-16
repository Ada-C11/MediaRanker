require "test_helper"

describe UsersController do
  before do
    @user = User.new(username: "cuppy")
  end
  describe "login_form" do
    it "renders without crashing" do

      # Act
      get login_path

      # Assert
      must_respond_with :ok
    end
  end

  describe "login" do
    it "adds a new user to the database" do
      # Arrange
      user_data = {
        user: {
          username: "new_user",
        },
      }

      # Act
      expect {
        post "/login", params: user_data
      }.must_change "User.count", +1

      # Assert
      must_redirect_to root_path

      check_flash

      user = User.last
      expect(user.username).must_equal user_data[:user][:username]
    end

    it "doesn't add an existing user to the database" do
      # Arrange
      user_data = {
        user: {
          username: "cuppy",
        },
      }

      # Act
      expect {
        post "/login", params: user_data
      }.wont_change "User.count"

      # Assert
      must_redirect_to root_path

      check_flash
    end

    it "responds with bad request with an invalid username" do
      # Arrange
      user_data = {
        user: {
          username: "",
        },
      }

      # Assumptions
      @user.assign_attributes(user_data[:user])
      expect(@user).wont_be :valid?

      # Act
      post login_path(@user), params: user_data

      # Assert
      must_respond_with :bad_request
      check_flash(:error)
    end
  end

  describe "logout" do
    # TODO: Test logout functionality
  end
end
