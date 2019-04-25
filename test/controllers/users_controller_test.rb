require "test_helper"

describe UsersController do
  describe "login" do
  end
  describe "current" do
    it "responds with success if a user is logged in" do
      logged_in_user = perform_login

      get current_user_path
      must_respond_with :success
    end
    it "responds with a redirect if no user is logged in" do
      get current_user_path
      must_respond_with :redirect
    end
  end
  describe "logout" do
  end
end

# def login
#   username = params[:name]
#   user = User.find_by(name: username)
#   user = User.create(name: username) if user.nil?
#   if user.id
#     session[:user_id] = user.id
#     flash[:alert] = "#{user.name} logged in"
#   else
#     flash[:error] = "Unable to log in"
#   end
#   redirect_to root_path
# end

# def current
#   @user = User.find_by(id: session[:user_id])
#   if @user.nil?
#     flash[:error] = "You must be logged in first!"
#     redirect_to root_path
#   end
# end

# def logout
#   user = User.find_by(id: session[:user_id])
#   session[:user_id] = nil
#   flash[:notice] = "Logged out #{user.name}"
#   redirect_to root_path
# end
