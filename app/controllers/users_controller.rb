class UsersController < ApplicationController
  before_action :find_user, only: [:login, :show]

  def index
    @users = User.all
  end

  def show; end

  def login_form
    @user = User.new
  end

  def login
    @user ||= @user = User.create(username: params["user"]["username"])
    session[:user_id] = @user.id

    flash[:success] = "Successfully logged in as #{@user.username}"

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

  private

  def find_user
    @user = User.find_by(id: params["user"]["username"])
  end
end
