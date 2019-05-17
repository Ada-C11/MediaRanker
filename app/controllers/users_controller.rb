class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = User.find_by(id: user_id)

    head :not_found unless @user
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)
    if user
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:message] = "Successfully created new user #{username} with ID #{user.id}"
    end

    redirect_to root_path
  end

  def logout
    session[:user_id] = nil

    flash[:status] = :success
    flash[:message] = 'Successfully logged out'

    redirect_to root_path
  end

  def current
    @current_user = User.find_by(id: session[:user_id])
    unless @current_user
      flash[:status] = :error
      flash[:message] = 'You must be logged in to see this page'
      redirect_to root_path
    end
  end
end
