class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    unless @user
      head :not_found
      return
    end
  end

  def index
    @users = User.all
  end

  def login
    username = params[:user][:name]
    user = User.find_by(name: username)
    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(name: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:status] = :warning
      flash[:message] = "You must be logged in to see this page"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end
end
