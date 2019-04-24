class UsersController < ApplicationController
  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user.nil?
      flash_msg = "Welcome new user!"
    else
      flash_msg = "Welcome back, #{username}!"
    end

    user ||= User.create(username: username)

    session[:user_id] = user.id
    flash[:success] = flash_msg
    redirect_to root_path
  end
end
