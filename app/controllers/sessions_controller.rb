class SessionsController < ApplicationController
  def login
    username = params[:username]
    if username and user = User.find_by(username: username)
      session[:user_id] = user.id
      flash[:status] = :success
      flash[:result_text] = "Welcome back, #{user.username}!"
    else
      user = User.new(username: username)
      if user.save
        session[:user_id] = user.id
        flash[:status] = :success
        flash[:result_text] = "New user created: #{user.username} with ID #{user.id}"
      else
        flash.now[:status] = :failure
        flash.now[:result_text] = "Login failed"
        flash.now[:messages] = user.errors.messages
        return
      end
    end
    redirect_to root_path
  end

  def logout
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "You have logged out."
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:status] = :success
    flash[:result_text] = "You have logged out."
    redirect_to root_path
  end

  def new
    @user = User.new
  end
end