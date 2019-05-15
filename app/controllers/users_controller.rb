class UsersController < ApplicationController
  def index
    @users = User.all.order(:created_at)
  end

  def show
    @user = User.find_by(id: session[:user_id])
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
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as an existing user #{user.username}"
    else 
      user = User.create(username: username)
      session[:user_id] = user.id 
      flash[:success] = "Successfully logged in as a new user #{user.username}"
    end

    redirect_to root_path
  end
  
  def current 
    @user = User.find(id: session[:user_id])

    unless @user 
      flash[:error] = "You must be logged in to see this page"
      redirect_to login_path 
      return
    end
  end

  def logout 
    session[:user_id] = nil

    flash[:success] = "Successfully logged out"

    redirect_to root_path
  end
end
