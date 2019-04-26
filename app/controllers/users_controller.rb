class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      flash[:status] = :success
      flash[:message] = "Succesfully logged in as returning user #{username}"
    else
      @user = User.create(username: username)
      flash[:status] = :success
      flash[:message] = "Succesfully logged in as new user #{username}"
    end
    session[:user_id] = @user.id

    redirect_to works_path
  end

  def current
    @user = User.find(session[:user_id])
    unless @user
      flash[:status] = :error
      flash[:message] = "You must be logged in to see this page."
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
