class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def index
    @users = User.all
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)

    if @user
      session[:user_id] = @user.id
      session[:username] = @user.username
      flash[:status] = :success
      flash[:message] = "Welcome back #{@user.username}"
    else
      @user = User.new(username: username)
      successful = @user.save
      if successful
        session[:user_id] = @user.id
        session[:username] = @user.username
        flash[:status] = :success
        flash[:message] = "Successfully logged in new user as #{@user.username}"
      else
        flash[:status ] = :error
        @user.errors.messages.each do |k, msg| 
          msg.each { |message| flash[:message] = "Could not log you in: #{k} #{message}" }
        end
      end
    end

    redirect_to root_path
  end

  def show
    @user = User.find_by(id: params[:id])

    unless @user
      head :not_found
      return
    end
  end

  def logout
    session[:user_id] = nil
    session[:username] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out"

    redirect_to root_path
  end
end
