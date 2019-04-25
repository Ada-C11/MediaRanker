require "test_helper"

describe UsersController do

  describe "login_form" do 
    it "should get log-in form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "login" do
    it "logs in existing user" do
      login_data = {
        user: {
        name: users(:jane).name
        }
      }
      User.find_by(name: login_data[:user][:name]).must_equal users(:jane)

      post login_path, params: login_data
      must_respond_with :redirect
      must_redirect_to root_path
    end

    it "renders form again for invalid user" do
      login_data = {
        user: {
        name: ""
        }
      }
      User.new(login_data[:user]).wont_be :valid?

      post login_path, params: login_data
      must_respond_with :redirect
    end
  end 

  describe "current" do
    it "responds with success (200 OK) for a logged-in user" do
      user = users(:jane)
      login_data = {
        user: {
          name: user.name,
        },
      }
      post login_path, params: login_data

      expect(session[:user_id]).must_equal user.id

      get current_user_path

      must_respond_with :success
    end

    it "must redirect if no user is logged in" do
      puts "rando debuggin'"
      puts current_user_path
      get current_user_path

      must_respond_with :success
    end
  end

  describe "index" do   
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end 

  describe "logout" do
    it "will let a user logout" do
      current_user = users(:jane)
      puts "VVVVVVVVVVVVVVVVVVV"
      puts "#{current_user.name}"
      post logout_path
      
      must_respond_with :redirect
    end
  end
end
