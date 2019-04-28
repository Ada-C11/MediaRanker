require "pry"

class UsersController < ApplicationController
  before_action :find_user

  def index
    @users = User.all
  end

  def login
    @user = User.find_by(name: params[:name])
    if @user.nil?
      @user = User.create(name: params[:name])
      flash[:success] = "Welcome #{@user.name}! You are logged in."
      session[:user_id] = @user.id
    else
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{@user.name}"
    end
    redirect_to root_path
  end

  def show
    user_id = params[:id]
    user = User.find_by(id: user_id)
    if user.nil?
      flash[:error] = "Unknown user"

      redirect_to users_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end
end
