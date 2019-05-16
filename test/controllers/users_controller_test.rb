require "test_helper"

describe UsersController do
  before do
    @user = User.create!(username: "test")
  end

  describe "index" do
    it "can get the index page" do
      get users_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid users's page" do
      get user_path(@user.id)

      must_respond_with :success
    end

    it "will redirect for an invalid work id" do
      get user_path(-1)

      must_respond_with :redirect
      must_redirect_to users_path
    end
  end

  describe "login_form" do
    it "can get the login page" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    it "can login a user" do
      user = perform_login

      expect(session[:user_id]).must_equal user.id

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end

  describe "logout" do
    it "logs out a user who was logged in" do
      user = perform_login

      expect(session[:user_id]).must_equal user.id

      post logout_path

      assert_nil(session[:user_id])

      must_respond_with :redirect
      must_redirect_to root_path
    end
  end
end
