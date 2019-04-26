require "pry"

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    user_id = params[:id]
    @user = user.find_by(id: user_id)
    unless @user
      head :not_found
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    @user ||= User.create(username: username)
    result = @user.save
    # binding.pry
    if result
      session[:user_id] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as returning user #{username}"
      redirect_to root_path
    else
      render :login_form, status: :bad_request
    end
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
