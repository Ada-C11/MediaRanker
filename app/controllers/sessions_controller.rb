class SessionsController < ApplicationController
  def login
    if user.nil?
      user = User.create(name: params[:author][:username], joined: Date.today)
    end

    user = User.find_by(name: params[:user][:username])

    session[:user_id] = user.id

    if user.valid?
      flash[:success] = "#{user.username} successfully logged in"
      redirect_to root_path
    else
      flash[:warning] = "A problem occurred: Could not log in"
      user.errors.messages.each do |field, messages|
        flash[field] = messages
      end
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @user = User.new
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_back(fallback_location: root_path)
  end
end
