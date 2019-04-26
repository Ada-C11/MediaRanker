class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]

    user = User.find_by(username: username)
    unless user
      user = User.create(username: username)
    end

    session[:user_id] = user.id

    flash[:status] = :success
    flash[:message] = "Successfully logged in as user #{user.username}"

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    unless @user
      flash[:status] = :error
      flash[:message] = "You must be logged in to do that"
      redirect_to login_path
      return
    end
  end

  def logout
    session[:user_id] = nil

    flash[:status] = :success
    flash[:message] = "Successfully logged out"

    redirect_to root_path
  end

  private

  def work_params
    return params.require(:user).permit(:username)
  end
end
