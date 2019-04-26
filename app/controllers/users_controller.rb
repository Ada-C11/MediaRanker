require "pry"

class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    @user = User.find_by(username: params[:user][:username])

    unless @user
      @user = User.new
      @user.username = params[:user][:username]
      @user.save
    end
    session[:user_id] = @user.id

    redirect_to current_user_path
  end

  def current
    @user = User.find_by(id: session[:user_id])

    unless @user
      flash[:status] = :error
      flash[:message] = "You must be logged in to do this"
      redirect_to login_path
    end
  end
end
