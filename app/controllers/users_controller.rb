class UsersController < ApplicationController
  
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)
    if @user
      session[:user_id] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as #{username}"
    else
      @user = User.create!(username: params[:user][:username])
      session[:user_id] = @user.id
      flash[:status] = :success
      flash[:message] = "Successfully logged in as #{username}"
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
end
