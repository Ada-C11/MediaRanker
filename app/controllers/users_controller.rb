class UsersController < ApplicationController
  before_action :find_user

  def index
    @users = User.all
  end

  def login
    username = params[:name]
    @user = User.create(name: username) if @user.nil?
    if @user.id
      session[:user_id] = @user.id
      flash[:alert] = "#{@user.name} logged in"
    else
      flash[:error] = "Unable to log in"
    end
    redirect_to root_path
  end

  def current
    if @user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Logged out #{@user.name}"
    redirect_to root_path
  end
end
