class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])
    if !@user
      flash[:error] = "User not found!"
      redirect_to users_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:alert] = "#{user.username} logged in!"
      redirect_to root_path
    else
      user = User.new(username: username, joined_date: Date.today)
      if user.save
        session[:user_id] = user.id
        flash[:alert] = "Successfully created new user #{user.username}!"
        redirect_to root_path
      else
        user.errors.messages.each do |field, messages|
          flash.now[field] = messages
        end
        render :login_form, status: :bad_request
      end
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    if user
      flash[:notice] = "Logged out #{user.username}"
    end
    redirect_to root_path
  end
end
