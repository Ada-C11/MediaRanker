require "test_helper"

describe UsersController do
  describe "login_form" do
    it "can get the login page" do
      get login_path

      must_respond_with :success
    end
  end

  describe "login" do
    before do
      @user = User.first
      @login_data = {
        user: {
          username: @user.username,
        },
      }
    end
    it "Will respond with redirect" do
      # user = User.first
      # login_data = {
      #   user: {
      #     username: user.username,
      #   },
      # }

      post login_path(@login_data)

      must_redirect_to root_path
    end
    it "will login a returning user" do
      # user = User.first
      # login_data = {
      #   user: {
      #     username: user.username,
      #   },
      # }

      post login_path(@login_data)

      expect(session[:user_id]).must_equal @user.id
    end

    it "will create an account for and login a new user" do
      # login_data = {
      #   user: {
      #     username: "new user",
      #   },
      # }
      @login_data[:user][:username] = "new user"

      new_user = User.find_by(username: @login_data[:user][:username])
      expect(new_user).must_equal nil

      post login_path(@login_data)
      new_user = User.find_by(username: @login_data[:user][:username])

      expect(new_user).must_be_instance_of User
      expect(session[:user_id]).must_equal new_user.id
    end

    # it "wont let someone login with a blank username" do
    # do i need this ?
    # end
  end
end
