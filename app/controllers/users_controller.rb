class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_or_create_by(username: username)

    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in!"
    else
      flash[:error] = "Unable to log in!"
    end
    redirect_to root_path
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.username}"
    redirect_to root_path
  end
end
