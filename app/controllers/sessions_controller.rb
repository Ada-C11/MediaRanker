class SessionsController < ApplicationController
  def login
    if user.nil?
      user = User.create(name: params[:author][:username])
    end

    user = User.find_by(name: params[:user][:username])

    session[:user_id] = user.id

    flash[:success] = "Logged in #{user.username}!"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Logged out!"
    redirect_back(fallback_location: root_path)
  end
end
