class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    name = params[:user][:name]
    user = User.find_by(name: name)
    if user.nil?
      user = User.create(name: name)
      session[:user_id] = user.id
      flash[:success] = "Successfully created new user #{user.name} with ID #{user.id}"
    else
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as existing user #{user.name}"
    end

    if user.id
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:success] = "Successfully logged out"
    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in to do that"
      redirect_to root_path
    else
      head :ok
      #   redirect_back(fallback_location: root_path)
    end
  end
end
