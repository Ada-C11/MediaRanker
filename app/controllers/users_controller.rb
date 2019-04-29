class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    if !@user
      flash[:error] = "Unknown user"

      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    user = User.create(username: username) if user.nil?

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in"
      redirect_to login_path
    else
      flash[:error] = "Unable to log in"
      redirect_to login_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
