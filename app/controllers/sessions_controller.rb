class SessionsController < ApplicationController
  def login
    @user = User.find_by(username: params[:user][:username])
    if @user
      flash[:success] = "Welcome back, #{@user.username}!"
      redirect_to root_path
    else
      @user = User.create(username: params[:user][:username], date_joined: DateTime.now)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "New user created: #{@user.username} with ID #{@user.id}"
        redirect_to root_path
        else
        flash.now[:failure] = "Login failed"
        render :new
      end
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out."
  end

  def new
    @user = User.new
  end
end