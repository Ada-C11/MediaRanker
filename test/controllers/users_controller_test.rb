require "test_helper"

describe UsersController do

  # describe "login_form" do 
  #   it "should get log-in form" do
  #     get login_path
  #     must_respond_with :success
  #   end
  # end

  describe "login" do
    ##### NEED TO FIX!!! ######
    # it "can log in an existing user" do
      
    #   perform_login

    #   get current_user_path
    #   must_respond_with :success
    # end

    it "renders form again for invalid user" do
      login_data = {
        user: {
        name: ""
        }
      }
      User.new(login_data[:user]).wont_be :valid?

      post login_path, params: login_data
      must_respond_with :bad_request
    end
  end 

  # describe "current" do
  #   it "responds with success (200 OK) for a logged-in user" do
  #     user = users(:jane)
  #     login_data = {
  #       user: {
  #         name: user.name,
  #       },
  #     }
  #     post login_path, params: login_data

  #     expect(session[:user_id]).must_equal user.id

  #     get current_user_path

  #     must_respond_with :success
  #   end
  #     ##### NEED TO FIX!!! ######
  #   it "must redirect if no user is logged in" do
  #     puts "rando debuggin'"
  #     puts current_user_path
  #     get current_user_path

  #     # expect(flash[:error]).must_equal "You must be logged in first!"
  #     must_respond_with :redirect
  #   end
  # end

  # describe "index" do   
  #   it "should get index" do
  #     get users_path
  #     must_respond_with :success
  #   end
  # end 


   ##### NEED TO FIX!!!! ######
  # describe "logout" do
  #   it "will let a user logout" do
  #     current_user = users(:jane)
  #     puts "VVVVVVVVVVVVVVVVVVV"
  #     puts "#{current_user.name}"
  #     post logout_path
      
  #     must_respond_with :redirect
  #   end
  # end





end
