class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)
    unless @user
      head :not_found
      return
    end
  end
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user.nil? 
      flash_msg = "Successfully logged in as user #{username}"
    else
      flash_msg = "Successfully logged in as returning user #{username}"
    end

    user ||= User.create(username: username)

    session[:user_id] = user.id
    flash[:success] = flash_msg
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

end
