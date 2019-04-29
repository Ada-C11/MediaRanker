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
    if user
      session[:user_id] = user.id
      flash[:alert] = "Successfully logged in as existing user #{user.username}"
    else 
      user = User.create(username: username)
      if user
        session[:user_id] = user.id
        flash[:alert] = "Successfully created new user #{user.username} with ID #{user.id}"
      else
        flash[:error] = "Unable to log in"
      end
    end        
    redirect_to homepage_path
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to login_path
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    return params.require(:user).permit(:username)
  end
end
