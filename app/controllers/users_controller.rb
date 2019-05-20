class UsersController < ApplicationController
  def login_form
    @user = User.new
  end

  def login
    username = params[:user][:username]
    user = User.find_by(username: username)
    if user #if is valid
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as returning user #{username}"
    else
      user = User.create(username: username)
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in as new user #{username}"
    end

    redirect_to root_path
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user.nil?
      flash[:error] = "Unknown user"

      redirect_to users_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username, vote_id: [])
  end
end
