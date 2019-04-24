class UsersController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])
    if user.nil?
      user = User.create(username: params[:user][:username])
      flash[:alert] = "#{user.username} logged in"
      session[:user_id] = user.id
    else
      session[:user_id] = user.id
      flash[:error] = "Unable to log in"
    end
    redirect_to root_path
  end

  def show
  end

  def index
  end

  def new
  end

  def create
  end
end
