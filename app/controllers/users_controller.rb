class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if !@user
      flash[:error] = "User not found!"
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_or_create_by(username: username, joined_date: Date.today)

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in!"
    else
      flash[:error] = "Unable to log in!"
    end
    redirect_to root_path
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    if user
      flash[:notice] = "Logged out #{user.username}"
    end
    redirect_to root_path
  end
end
