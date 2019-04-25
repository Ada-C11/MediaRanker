require "test_helper"

describe UsersController do

  describe "index, show" do   
    it "should get index" do
      get users_path
      must_respond_with :success
    end

    it "should get show" do 
      user = users(:jane)
      
      get user_path(user.id)
      must_respond_with :success
    end
  end 

  describe "login" do 
    it "should get log-in form" do
      get login_path
      must_respond_with :success
    end
  end

  describe "current" do
    it "responds with a redirect if no user is logged in" do 
      get current_user_path
      must_respond_with :redirect
    end

    # it "responds with success if user is logged in" do
    #   logged_in_user = perform_login

    #   get current_user_path(logged_in_user)
    #   must_respond_with :success
    # end

    it "recognizes existing user" do
      existing_user = users(:jane)
      get login_path(name: existing_user.name)
      must_respond_with :success

    end
  end

  it "renders form again for invalid user" do
    new_user = User.create(name: "")

    get login_path
    must_respond_with :success
  end

  describe "create" do
    it "can create a new user" do
      new_user = User.create(name: "thenightking")

      get login_path
      must_respond_with :success
    end
  end

  describe "logout" do
    it "will let a user logout" do
      current_user = users(:john)
      puts "VVVVVVVVVVVVVVVVVVV"
      puts "#{current_user.name}"
      # post logout_path
      # must_respond_with :found
      # must_respond_with :redirect
    end
  end





end
