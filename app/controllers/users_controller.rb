class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params["user"]["username"])

    @user ||= @user = User.create(username: params["user"]["username"])

    session[:user_id] = @user.id

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    unless @user
      flash[:error] = "You must be logged in to see this page"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
