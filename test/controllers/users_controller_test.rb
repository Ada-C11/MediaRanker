require "test_helper"

describe UsersController do
  describe "index" do
    it "can get the index page" do

      # Act
      get users_path

      # Assert
      must_respond_with :success
    end
  end

  describe "show" do
    it "can get the user detail page" do

      # Act
      get user_path(User.first.id)
      # Assert
      must_respond_with :success
    end

    it "shows a 404 if user isn't found" do
      user_id = -1
      # Act
      get user_path(user_id)

      # Assert
      must_respond_with :not_found
    end
  end

  describe "login_form" do
    it "can get the login form page" do

      # Act
      get login_path

      # Assert
      must_respond_with :success
    end
  end

  describe "login" do
    before do
      @user = User.first
      @login_data = {
        user: {
          username: @user.name,
        },
      }
    end

    it "Will respond with redirect" do
      post login_path(@login_data)

      must_redirect_to root_path
    end
    it "will login a returning user" do
      post login_path(@login_data)

      expect(session[:user_id]).must_equal @user.id
    end

    it "will create an account for and login a new user" do
      @login_data[:user][:username] = "new user"

      new_user = User.find_by(username: @login_data[:user][:username])
      expect(new_user).must_be_nil

      post login_path(@login_data)
      new_user = User.find_by(username: @login_data[:user][:username])

      expect(new_user).must_be_instance_of User
      expect(session[:user_id]).must_equal new_user.id
    end
  end

  describe "current" do
    it "returns 200 OK for a logged-in user" do
      perform_login

      get current_user_path

      must_respond_with :success
    end

    it "Redirects to login page if not logged in" do
      get current_user_path

      expect(flash[:status]).must_equal :warning
      expect(flash[:message]).must_equal "You must be logged in to do this"
      must_redirect_to login_path
    end
  end

  describe "logout" do
    it "returns 200 OK for a logged-in user" do
      perform_login

      post logout_path

      must_redirect_to root_path
      expect(session[:user_id]).must_be_nil
    end

    it "returns 200 OK if there is no logged-in user" do
      get root_path
      expect(session[:user_id]).must_be_nil

      post logout_path

      must_redirect_to root_path
    end
  end
end
