class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :find_current, only: [:logout, :current_user]

  def index
    @users = User.all
  end

  def show
    if !@user
      flash[:error] = "No user with that ID found."
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if !user
      user = User.new(username: username)
      success = user.save
      if success
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{username} with ID #{user.id}"
      else
        flash[:error] = "There was an error saving a user: #{user.errors.messages}"
      end
    elsif user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}"
    end

    redirect_to root_path
  end

  def logout
    if @current
      session[:user_id] = nil
      flash[:success] = "Successfully logged out #{@current.username}"
    else
      flash[:error] = "There was no logged in user to log out."
    end

    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def find_current
    @current = User.find_by(id: session[:user_id])
  end
end
