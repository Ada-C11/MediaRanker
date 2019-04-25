class UsersController < ApplicationController
  before_action :find_user, only: [:current, :logout]

  def login_form
    @user = User.new
  end

  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      user = User.create(username: username)
    end

    if @user.id
      session[:user_id] = user.id
      flash[:alert] = "Successfully logged in as existing user #{user.username}"
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must log in to do that"
      redirect_to root_path
    end
  end

  def logout
    # user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end
end
