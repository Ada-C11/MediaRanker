class SessionsController < ApplicationController
  def login
    user = User.find_by(username: params[:user][:username])

    if user.nil?
      user= User.create(username: params[:user][:username], date_joined: DateTime.now)
    end

    session[:user_id] = user.id
    flash[:success] = "Successfully logged in as #{user.username}"
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back fallback_location: root_path
  end
end