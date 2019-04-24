class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as a returning user!"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as a new user!"
    end
    redirect_to root_path
  end

  def current
  end

  def logout
  end
end
