require "test_helper"

describe UsersController do
  describe "users#index" do
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end

  let(:user) { users(:one) }
  describe "users#show" do
    it "should get show with valid id" do
      id = user.id
      get user_path(id)
      must_respond_with :success
    end

    it "should return a 404 with invalid id" do
      invalid_id = -1
      get user_path(invalid_id)
      must_respond_with :not_found
    end
  end

  describe "users#login_form" do
    it "will get to log in page" do
      get login_user_path
      must_respond_with :success
    end
  end

  describe "users#login" do
    it "will create a new user if username does not exist" do
      params = { user: { username: "new_user" } }
      expect {
        post login_user_path params: params
      }.must_change "User.count", 1
      user = User.last

      expect(user.username).must_equal params[:user][:username]
      expect(flash[:success]).must_equal "Successfully created new user #{user.username} new with ID #{user.id}"
      expect(session[:user_id]).must_equal user.id
      must_redirect_to root_path
    end

    it "will login existing user" do
      username = user.username
      params = { user: { username: username } }

      expect {
        post login_user_path params: params
      }.must_change "User.count", 0

      user = User.find_by(username: username)
      expect(user.username).must_equal params[:user][:username]
      expect(flash[:success]).must_equal "Successfully logged in as existing user #{user.username}"
      expect(session[:user_id]).must_equal user.id

      must_redirect_to root_path
    end
  end

  describe "user#logout" do
    it "will log out user" do
      username = user.username
      params = { user: { username: username } }
      # sets session id
      post login_user_path params: params
      expect(session[:user_id]).must_equal user.id

      expect {
        post logout_user_path
      }.wont_change "User.count"

      expect(session[:user_id]).must_be_nil
      expect(flash[:success]).must_equal "Successfully logged out"

      must_redirect_to root_path
    end
  end
end
