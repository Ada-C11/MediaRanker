class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if !@user
      head :not_found
    end
  end

  def login_form
    @user = User.new
  end

   def login
    username = params[:user][:name]
    user = User.find_by(name: username)

    
    if user
      session[:user_id] = user.id
      flash[:alert] = "#{user.name} logged in"
      # redirect_to root_path
    else
      user = User.create(name: username)
    end

    if !user
      flash[:error] = "Unable to login"
    end

    redirect_to root_path
  end

  def current
    @user = User.find_by(id: session[:user_id])
    if @user.nil?
      flash[:error] = "You must be logged in first!"
      redirect_to root_path
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    redirect_to root_path
    flash[:notice] = "You have been successfully logged out"
    session[:user_id] = nil
  end

  private

  def user_params
    return params.require(:user).permit(:name)
  end
end
