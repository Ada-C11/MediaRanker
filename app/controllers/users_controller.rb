class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)
    unless user
      # new user
      user = User.create(username: username)
    end

    session[:user_id] = user.id

    flash[:message] = "Successfully logged in as user #{user.username}"

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil

    flash[:message] = "Successfully logged out"

    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by(id: params[:id])

    unless @user
      head :not_found
      return
    end
  end
end
