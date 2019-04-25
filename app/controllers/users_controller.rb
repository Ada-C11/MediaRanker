class UsersController < ApplicationController
  
  def login_form
    @user = User.new
  end

  def login
    user_name = params[:user][:username]
    @user = User.find_by(username: user_name)

    if @user
      flash[:status] = :success
      flash[:message] = "Hello #{@user.username} you are successfully logged in"
    else 
      User.create(username: user_name)
      flash[:status] = success
      flash[:message = "Successfully created #{@user.username}"
    end

  end
end
