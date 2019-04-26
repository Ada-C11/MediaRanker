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
      flash[:alert] = "Successfully created new user #{user.name} with ID #{user.id}"
    else
      session[:user_id] = user.id
      flash[:alert] = "Successfully logged in as existing user #{user.name}"
    end

    if user.id
      redirect_to root_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:notice] = "Successfully logged out"
    redirect_to root_path
  end

  def index
  end

  def show
    @user = User.find_by(id: params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
