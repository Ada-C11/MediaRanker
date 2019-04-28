

class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    unless @user
      head :not_found
      return
    end
  end

  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    unless @user
      @user = User.new
      @user.username = params[:user][:username]
      @user.save
    end
    session[:user_id] = @user.id
    flash[:status] = :success
    flash[:message] = "Successfully logged in as #{@user.username}"

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    unless @user
      flash[:status] = :warning
      flash[:message] = "You must be logged in to do this"
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"
    redirect_to root_path
  end
end
