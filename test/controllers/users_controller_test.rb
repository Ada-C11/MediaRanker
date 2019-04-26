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

      logged_in_user = perform_login
      get current_user_path
      must_respond_with :success
    end

    it "must redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end

  describe "index" do   
    it "should get index" do
      get users_path
      must_respond_with :success
    end
  end 

  describe "show" do
    it "returns success when given a vaild id" do
      user = User.create(name: 'Faiza')
      user_id = user.id
      get user_path(user_id)
      must_respond_with :success
    end
    
    it "returns not_found when given an invaild id" do
      user_id = -1
      get user_path(user_id)
      must_respond_with :not_found
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
