class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user
      flash[:success] = "Successfully logged in as existing user #{user.username}"
    else
      user = User.new(username: username)
      flash[:success] = "Successfully created new user #{user.username} new with ID #{user.id}"
    end
    session[:user_id] = user.id
    redirect_to root
  end

  def logout
  end
end
