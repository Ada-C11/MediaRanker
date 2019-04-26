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
  end
end
