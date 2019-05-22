require "test_helper"

describe UsersController do
  before do
    @user = User.first
  end

  describe "index" do
    it "renders without crashing" do
      # Arrange

      # Act
      get users_path

      # Assert
      must_respond_with :ok
    end

    it "renders even if there are zero users" do
      # Arrange
      User.destroy_all

      # Act
      get users_path

      # Assert
      must_respond_with :ok
    end
  end

  describe "show" do
    it "returns a 404 status code if the user doesn't exist" do
      user_id = -1

      get user_path(user_id)

      must_respond_with :not_found
    end

    it "users for a user that exists" do
      get user_path(@user)

      must_respond_with :ok
    end
  end

  describe "login_form" do
    it "returns a 200 ok status code" do
      get login_path

      must_respond_with :ok
    end
  end

  describe "login" do
    it "logs in a returning user" do
      perform_login

      must_respond_with :redirect
      check_flash
      must_redirect_to root_path
    end

    it "creates new user at login" do
      user_data = {
        user: {
          username: "bigbird",
        },
      }

      post login_path(params: user_data)

      must_respond_with :redirect
      user = User.last

      expect(session[:user_id]).must_equal user.id
      check_flash
      must_redirect_to root_path
    end

    it "rejects login with bad user data" do
      user_data = {
        user: {
          username: "",
        },
      }

      expect(User.new(user_data[:user])).wont_be :valid?

      expect {
        post login_path, params: user_data
      }.wont_change "User.count"

      must_respond_with :bad_request
    end
  end

  describe "logout" do
    it "logs out a user" do
      perform_login
      post logout_path
      must_respond_with :redirect
      check_flash
      expect(session[:user_id]).must_be_nil
      must_redirect_to root_path
    end
  end
end
