class UsersController < ApplicationController
  before_action :find_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    unless @user
      head :not_found
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
      flash[:status] = :success
      flash[:message] = "Welcome back, #{username}!"
    else
      @user = User.new(user_params)
      unless @user.save
        flash[:status] = :error
        flash[:message] = "Please try again."
        render :login_form, status: :bad_request
        return
      else
        session[:user_id] = User.find_by(id: @user.id)
        flash[:status] = :success
        flash[:message] = "Nice to meet you, #{username}!"
      end
    end

    redirect_to root_path
  end

  def logout
    flash[:status] = :success
    flash[:message] = "Successfully logged out!  See you later, 'gator."
    session[:user_id] = nil

    redirect_to root_path
  end

  private

  def user_params
    return params.require(:user).permit(:username)
  end

  def find_user
    @user = User.find_by_id(params[:id])
  end
end
