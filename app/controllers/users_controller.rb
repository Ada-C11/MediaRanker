class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if !user
      user = User.create(username: username)
    end
    session[:user_id] = user.id
    flash[:status] = :success
    flash[:message] = "Successfully logged in as #{username}"
    redirect_to root_path
  end

  def logout
    user_id = session[:user_id]
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out #{User.find_by(id: user_id).username}"
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: params[:id])

    if !@user
      redirect_to login_path
      return
    end
    @votes = Vote.where(user_id: @user.id)
  end
end
