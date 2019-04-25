class UsersController < ApplicationController
  def login
    username = params[:name]
    user = User.find_by(name: username)
    user = User.create(name: username) if user.nil?
    if user.id
      session[:user_id] = user.id
      flash[:alert] = "#{user.name} logged in"
    else
      flash[:error] = "Unable to log in"
    end
    redirect_to root_path
  end

  def current
    user = User.find_by(id: session[:user_id])
    if user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Logged out #{user.name}"
    redirect_to root_path
  end
end
