class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show; end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params["user"]["username"])
    if @user
      flash[:success] = "Successfully logged in as returning user #{@user.username}"
      session[:user_id] = @user.id
      redirect_to root_path
      return
    end
    @user ||= User.new(username: params["user"]["username"])
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as new user #{@user.username}"
      redirect_to root_path
    else
      flash.now[:error] = "A problem occured. Could not log in"
      render :login_form
    end
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

  private

  def find_user
    @user ||= User.find_by(id: params["id"])
  end
end
