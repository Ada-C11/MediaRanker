class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      flash.now[:status] = :error
      flash.now[:message] = "Could not find that user."
      redirect_to users_path
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      flash[:status] = :success
      flash[:message] = "Succesfully logged in as existing user #{username}"
    else
      @user = User.create(username: username)
      flash[:status] = :success
      flash[:message] = "Succesfully created new user #{username} with ID #{@user.id}"
    end
    session[:user_id] = @user.id

    redirect_to works_path
  end

  def current
    @user = User.find(session[:user_id])
    unless @user
      flash[:status] = :warning
      flash[:message] = "You must be logged in to see this page."
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"

    redirect_to root_path
  end
end
