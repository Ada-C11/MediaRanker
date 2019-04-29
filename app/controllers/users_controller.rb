class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find_by(id: params[:id])

    if !@user
      flash[:warning] = "User not found."
      redirect_to root_path
    end
  end

  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    @user = User.find_by(username: username)

    if @user
      session[:user_id] = @user.id
      flash[:success] = "Successfully logged in as existing user #{username}!"
      redirect_to root_path
      return
    else
      @user = User.new(username: username, join_date: Date.current)
      if @user.save
        session[:user_id] = @user.id
        flash[:success] = "Successfully created new user #{username} with ID #{@user.id}!"
        redirect_to root_path
      else
        flash.now[:warning] = "Log in unsuccessful. Please try again"
        render :login_form, status: :bad_request
      end
    end
  end

  def logout
    user = User.find_by(id: session[:user_id])
    session[:user_id] = nil
    flash[:success] = "Succesfully logged out"
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end
end
