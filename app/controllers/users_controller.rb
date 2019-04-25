class UsersController < ApplicationController
  
  def login_form
    @user = User.new
  end

  def login
    user_name = params[:user][:username]
    @user = User.find_by(username: user_name)

    unless @user 
      flash[:status] = :danger
      flash[:message]
  end


end
