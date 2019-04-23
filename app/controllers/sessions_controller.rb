class SessionsController < ApplicationController
  def login
    user = User.find_by(name: params[:user][:name])

    if user.nil?
      user = User.create(name: params[:author][:name])
    end

    session[:user_id] = user.id
    flash[:sucess] = "Successfully logged in as #{user.name}"
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