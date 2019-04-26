class SessionsController < ApplicationController
  def login
    username = params[:username]
    if !username.nil? && user = User.find_by(username: username)
      flash[:success] = "Welcome back, #{user.username}!"
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:success] = "New user created: #{user.username} with ID #{user.id}"
      else
        flash.now[:failure] = "Login failed"
        render :new
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:success] = "You have logged out."
  redirect_to root_path
  end
end