class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if !@user
      flash[:failure] = "User Not Found."
      redirect_to root_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    # needs flash message & session shiz
    username = params[:user][:username]
    user = User.find_by(username: username)

    if user
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{username}!"
    else
      user = User.create(username: username, join_date: Date.current)
      if user.id
        session[:user_id] = user.id
        flash[:success] = "Successfully created new user #{username} with ID #{user.id}!"
      end
    end

    if !user.id
      flash.now[:failure] = "Login Unsuccessful. Please Try Again"
    end

    redirect_to root_path
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Succesfully logged out"
    redirect_to root_path
  end
end
