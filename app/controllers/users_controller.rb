class UsersController < ApplicationController
  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    user ||= User.create(username: username)

    session[:user_id] = user.id
    flash[:success] = "#{username} is logged in."
    redirect_to root_path
  end
end
